//
//  Optional.swift
//  PartneriOSTraining
//
//  Created by Kevin Poorman on 2/20/20.
//  Copyright © 2020 PartneriOSTrainingOrganizationName. All rights reserved.
//

import Foundation
extension Optional where Wrapped == String {

  var _nonOptional: String? { //swiftlint:disable:this identifier_name
    get {
      return self
    }
    set {
      self = newValue
    }
  }
  public var nonOptional: String {
    get {
      return _nonOptional ?? ""
    }
    set {
      _nonOptional = newValue.isEmpty ? nil : newValue
    }
  }
}
