//
//  Env.swift
//  PartneriOSTraining
//
//  Created by Kevin Poorman on 2/19/20.
//  Copyright © 2020 PartneriOSTrainingOrganizationName. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import SalesforceSDKCore
import SmartStore

class Env: ObservableObject {
  let soupName = "MostAwesomeSoup"
  lazy var sfUserObject = UserAccountManager.shared.currentUserAccount!
  lazy var customOfflineStore = SmartStore.shared(withName: "customStore", forUserAccount: self.sfUserObject)
  lazy var customSoup = customOfflineStore?.registerSoup(withName: soupName, withIndexPaths: ["foo", "id"])
  @Published var queryResults: [String:Any] = [:]
  @Published var foo: String = ""
  
  private var customSoupPublisher: AnyCancellable?
  
  public func insertAndQuerySmartStore(){
    guard customSoup != nil else {return}
    customOfflineStore?.clearSoup(soupName)
    let exampleDictionary = ["foo": "Bar", "id":"1"]
    customOfflineStore?.upsert(entries: [exampleDictionary], forSoupNamed: soupName)
    customSoupPublisher = self.customOfflineStore?.publisher(for: "select * from {\(soupName)}")
      .map{ $0[0] as! [Any]}
      .map{ $0[1] as! [String:Any]}
      .replaceError(with: [:])
      .assign(to: \.queryResults, on:self)
    self.foo = self.queryResults["foo"] as! String
  }
  
  public func updateSoupRecord(){
    queryResults["foo"] = "New Value"
    do {
      try customOfflineStore?.upsert(entries: [queryResults], forSoupNamed: soupName, withExternalIdPath: "id")
    } catch {
      print("Something went wrong")
    }
    customSoupPublisher = self.customOfflineStore?.publisher(for: "select * from {\(soupName)}")
      .map{ $0[0] as! [Any]}
      .map{ $0[1] as! [String:Any]}
      .replaceError(with: [:])
      .assign(to: \.queryResults, on:self)
    self.foo = self.queryResults["foo"] as! String
  }
  
}

