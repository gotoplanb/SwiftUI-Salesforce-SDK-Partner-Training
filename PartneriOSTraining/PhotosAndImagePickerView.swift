//
//  PhotosAndImagesView.swift
//  PartneriOSTraining
//
//  Created by Kevin Poorman on 2/21/20.
//  Copyright © 2020 PartneriOSTrainingOrganizationName. All rights reserved.
//

import SwiftUI
import Tatsi
import Photos

struct PhotosAndImagePickerView: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var env: Env
  @Binding var selectedImages: [UIImage]

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIViewController(context: Context) -> TatsiPickerViewController {
    var config = TatsiConfig.default
    config.showCameraOption = true
    config.singleViewMode = true
    config.supportedMediaTypes = [.image]
    config.firstView = .userLibrary
    config.maxNumberOfSelections = 4
    let picker = TatsiPickerViewController(config: config)
    picker.delegate = context.coordinator
    picker.pickerDelegate = context.coordinator
    picker.modalPresentationStyle = .fullScreen
    return picker
  }

  func updateUIViewController(_ uiViewController: TatsiPickerViewController, context: Context) {}

  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, TatsiPickerViewControllerDelegate {
    var parent: PhotosAndImagePickerView

    init(_ parent: PhotosAndImagePickerView) {
      self.parent = parent
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      picker.dismiss(animated: true, completion: nil)
    }

    func pickerViewController(_ pickerViewController: TatsiPickerViewController, didPickAssets assets: [PHAsset]) {
      for asset in assets {
        if let image = getUIImage(from: asset) {
          self.parent.selectedImages.append(image)
        }
      }
      parent.presentationMode.wrappedValue.dismiss()
    }

    private func getUIImage(from asset: PHAsset) -> UIImage? {
      var img: UIImage?
      let manager = PHImageManager.default()
      let options = PHImageRequestOptions()
      options.version = .original
      options.isSynchronous = true
      manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { data, _ in
        if let data = data {
          img = data
        }
      }
      return img
    }

  }

}
