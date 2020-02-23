//
//  Toast.swift
//  PartneriOSTraining
//
//  Created by Kevin Poorman on 2/21/20.
//  Copyright © 2020 PartneriOSTrainingOrganizationName. All rights reserved.
//

import SwiftUI

struct Toast<Presenting>: View where Presenting: View {
  @Binding var isShowing: Bool

  let presenting: () -> Presenting
  let text: Text

  var body: some View {
    if self.isShowing {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        withAnimation {
          self.isShowing = false
        }
      }
    }
    return GeometryReader { geo in
      ZStack(alignment: .center) {
        self.presenting().blur(radius: self.isShowing ? 1 : 0)
        VStack {
          self.text
        }
        .frame(width: geo.size.width / 2, height: geo.size.height / 5)
        .background(Color.secondary.colorInvert())
        .foregroundColor(Color.primary)
        .cornerRadius(20)
        .transition(.slide)
        .opacity(self.isShowing ? 1 : 0)
      }
    }
  }
}
