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
  static let apiVersion = "v47.0"
  
  typealias JSONKeyValuePairs = [String:Any]
  typealias SalesforceRecord = [String:Any]
  typealias SalesforceRecords = [SalesforceRecord]
  
  func updateRecord(withObjectType objType: String, fields: [String:Any]) -> AnyPublisher<SalesforceRecord, Never> {
    let id = fields["Id"] as! String
    let request = self.requestForUpdate(withObjectType: objType, objectId: id, fields: fields, apiVersion: RestClient.apiVersion)
    return self.publisher(for: request)
      .print()
      .tryMap { try $0.asJson() as? JSONKeyValuePairs ?? [:] }
      .map { $0["records"] as? SalesforceRecords ?? [] }
      .map {$0[0]}
      .mapError { dump($0) }
      .replaceError(with: [:])
      .eraseToAnyPublisher()
  }
  
  func updateContact(_ contact: Contact) -> AnyPublisher<SalesforceRecord, Never> {
    return self.updateRecord(withObjectType: "Contact", fields: contact.asDictionary())
  }
}
