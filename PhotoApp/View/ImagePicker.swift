//
//  ImagePicker.swift
//  PhotoApp
//
//  Created by Тимур Мурадов on 06.04.2024.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    //MARK: - Properties
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
}

