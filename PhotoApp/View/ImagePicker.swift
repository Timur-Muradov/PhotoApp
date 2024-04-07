//
//  ImagePicker.swift
//  PhotoApp
//
//  Created by Тимур Мурадов on 06.04.2024.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var picker: Bool
    @Binding var imageData: Data
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let picker = PHPickerViewController(configuration: PHPickerConfiguration())
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
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
}

