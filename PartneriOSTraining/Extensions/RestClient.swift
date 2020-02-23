//
//  RestClient.swift
//  PartneriOSTraining
//
//  Created by Kevin Poorman on 2/20/20.
//  Copyright © 2020 PartneriOSTrainingOrganizationName. All rights reserved.
//

import Foundation
import SalesforceSDKCore
import Combine

extension RestClient {
  static let apiVersion = "v48.0"

  typealias JSONKeyValuePairs = [String:Any]
  typealias SalesforceRecord = [String:Any]
  typealias SalesforceRecords = [SalesforceRecord]

  func updateContact(_ contact: Contact) -> AnyPublisher<Bool, Never> {
    return self.updateRecord(withObjectType: "Contact", fields: contact.asDictionary())
  }

  func attach(file: Data, toRecord id: String, withFilename filename: String) -> AnyPublisher<Bool, Never> {
    let attachmentRequest = self.requestForCreatingAttachment(from: file, withFileName: filename, relatingToId: id)
    return self.publisher(for: attachmentRequest)
      .map { $0.urlResponse as! HTTPURLResponse } // swiftlint:disable:this force_cast
      .map { $0.statusCode == 201 }
      .mapError { dump($0) }
      .replaceError(with: false)
      .eraseToAnyPublisher()
  }

  func attach(files: [Data], toRecord id: String, fileType: String) -> AnyPublisher<Bool, Never> {
    let compositeRequestBuilder = CompositeRequestBuilder().setAllOrNone(false)
    for file in files {
      let filename = UUID().uuidString + fileType
      compositeRequestBuilder.add(
        self.requestForCreatingAttachment(from: file, withFileName: filename, relatingToId: id),
        referenceId: UUID().uuidString
      )
    }
    let compositeRequest = compositeRequestBuilder.buildCompositeRequest(RestClient.apiVersion)
    print("Halting for composite Requests")
    return self.publisher(for: compositeRequest)
      .map { $0.subResponses }
      .map { return $0.map { subResponse in return subResponse.httpStatusCode} }
      .removeDuplicates()
      .map { $0[0] == 201 }
      .replaceError(with: false)
      .eraseToAnyPublisher()
  }

  func createAccount() -> AnyPublisher<String?, Never> {
    let request = self.requestForCreate(withObjectType: "Account", fields: ["name":"testAccount"], apiVersion: RestClient.apiVersion)
    return createReturningId(request: request)
  }

  func createContact(accountId: String) -> AnyPublisher<String?, Never> {
    let request = self.requestForCreate(withObjectType: "Contact",
                                        fields: ["LastName": "Testing", "AccountId": accountId],
                                        apiVersion: RestClient.apiVersion)
    return createReturningId(request: request)
  }

  func createContact(contact: Contact) -> AnyPublisher<String?, Never> {
    let fields = contact.asDictionary()
    let fieldsMinusId = fields.filter { $0.key != "Id" }
    let request = self.requestForCreate(withObjectType: "Contact", fields: fieldsMinusId, apiVersion: RestClient.apiVersion)
    return createReturningId(request: request)
  }

  private func createReturningId(request: RestRequest) -> AnyPublisher<String?, Never> {
    return self.publisher(for: request)
      .print("Create Account")
      .tryMap { try $0.asJson() as? RestClient.JSONKeyValuePairs ?? [:]}
      .tryMap { keyValuePairs in
        guard let id = keyValuePairs["id"] as? String else {return ""}
        return id
      }
      //.map { $0["id"] as! String?}
      .replaceError(with: "")
      .eraseToAnyPublisher()
  }

  private func updateRecord(withObjectType objType: String, fields: [String:Any]) -> AnyPublisher<Bool, Never> {
    let id = fields["Id"] as! String // swiftlint:disable:this force_cast
    let fieldsMinusId = fields.filter { $0.key != "Id" }
    let request = self.requestForUpdate(withObjectType: objType, objectId: id, fields: fieldsMinusId, apiVersion: RestClient.apiVersion)
    return self.publisher(for: request)
      .map { $0.urlResponse as! HTTPURLResponse } // swiftlint:disable:this force_cast
      .map { $0.statusCode == 204 }
      .mapError { dump($0) }
      .replaceError(with: false)
      .eraseToAnyPublisher()
  }

  private func requestForCreatingAttachment(
    from data:Data, withFileName fileName: String, relatingToId id: String
  ) -> RestRequest {
    let record = ["VersionData": data.base64EncodedString(options: .lineLength64Characters),
                  "Title": fileName,
                  "PathOnClient": fileName,
                  "FirstPublishLocationId": id
    ]
    return self.requestForCreate(withObjectType: "ContentVersion", fields: record, apiVersion: RestClient.apiVersion)
  }

}
