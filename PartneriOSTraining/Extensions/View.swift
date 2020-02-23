//
//  View.swift
//  PartneriOSTraining
//
//  Created by Kevin Poorman on 2/21/20.
//  Copyright © 2020 PartneriOSTrainingOrganizationName. All rights reserved.
//

import Foundation
import SwiftUI

extension View {

  func toast(isShowing: Binding<Bool>, text: Text) -> some View {
    Toast(isShowing: isShowing, presenting: { self }, text: text)
  }

}
