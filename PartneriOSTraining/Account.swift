//
//  Account.swift
//  PartneriOSTraining
//
//  Created by Kevin Poorman on 2/23/20.
//  Copyright © 2020 PartneriOSTrainingOrganizationName. All rights reserved.
//

import Foundation
/*
 Data Model object for a single Account
 */
struct Account: Hashable, Identifiable, Decodable {
  let id: String
  let name: String
  let industry: String

  static func generateDemoAccounts(numberOfAccounts: Int) -> [Account] {
    var accounts = [Account]()
    for idx in 1...numberOfAccounts {
      accounts.append(
        Account(id: "PRE1234\(idx)", name: "Demo Account - \(idx)", industry: "Industry - \(idx)")
      )
    }
    return accounts
  }
}
