//
//  Repository.swift
//  PartneriOSTraining
//
//  Created by Kevin Poorman on 2/23/20.
//  Copyright © 2020 PartneriOSTrainingOrganizationName. All rights reserved.
//

import Foundation
struct Repository: Identifiable, Decodable {
  let id: Int
  var name: String?
  var html_url: String? //swiftlint:disable:this identifier_name
  var braches_url: String? //swiftlint:disable:this identifier_name
  var full_name: String? //swiftlint:disable:this identifier_name
  var issues_url: String? //swiftlint:disable:this identifier_name
}
