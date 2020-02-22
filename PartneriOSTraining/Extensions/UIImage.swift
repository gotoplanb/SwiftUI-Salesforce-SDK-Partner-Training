//
//  UIImage.swift
//  PartneriOSTraining
//
//  Created by Kevin Poorman on 2/21/20.
//  Copyright © 2020 PartneriOSTrainingOrganizationName. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  func resizedBy(_ multiplier: CGFloat) -> UIImage {
    let newSize = CGSize(width: self.size.width * multiplier, height: self.size.height * multiplier)
    let rect = CGRect(origin: .zero, size: newSize)
    
    // resize the image
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    self.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
  func resizeByHalf() -> UIImage {
    return resizedBy(0.5)
  }
  
  func resizeByQuarter() -> UIImage{
    return resizedBy(0.25)
  }
}
