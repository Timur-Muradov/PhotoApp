//
//  Coordinator.swift
//  PhotoApp
//
//  Created by Тимур Мурадов on 10.04.2024.
//

import PhotosUI
import SwiftUI

class Coordinator: NSObject, PHPickerViewControllerDelegate {
    
    var parent: ImagePicker
    
    init(parent: ImagePicker) {
        self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if !results.isEmpty {
            if results.first!.itemProvider.canLoadObject(ofClass: UIImage.self) {
                results.first!.itemProvider.loadObject(ofClass: UIImage.self) { (Image, err) in
                    DispatchQueue.main.async {
                        self.parent.imageData = (Image as! UIImage).pngData()!
                        self.parent.picker.toggle()
                    }
                }
            }
        } else {
            self.parent.picker.toggle()
        }
    }
}

