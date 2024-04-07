//
//  HomeViewModel.swift
//  PhotoApp
//
//  Created by Тимур Мурадов on 07.04.2024.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class HomeViewModel: ObservableObject {
    
    @Published var imagePicker = false
    @Published var imageData = Data(count: 0)
    @Published var allImages: [FilteredImage] = []
    @Published var mainView: FilteredImage!
    @Published var value: CGFloat = 1.0
    @Published var imageScale: CGFloat = 1.0
    @Published var imageRotation: Double = 0.0
    
    let filters: [CIFilter] = [
        CIFilter.sepiaTone(), CIFilter.photoEffectFade(), CIFilter.colorMonochrome(), CIFilter.photoEffectChrome(), CIFilter.bloom(), CIFilter.gaussianBlur(), CIFilter.colorCurves()
    ]
    
    
    func loadFilter() {
        let context = CIContext()
        filters.forEach { (filter) in
            DispatchQueue.global(qos: .userInteractive).async {
                let ciImage = CIImage(data: self.imageData)
                filter.setValue(ciImage!, forKey: kCIInputImageKey)
                
                guard let newImage = filter.outputImage else { return }
                
                let cgImage = context.createCGImage(newImage, from: newImage.extent)
                let isEditable = filter.inputKeys.count > 1
                let filteredData = FilteredImage(image: UIImage(cgImage: cgImage!), filter: filter, isEditable: isEditable)
                
                DispatchQueue.main.async {
                    self.allImages.append(filteredData)
                    if self.mainView == nil { self.mainView = self.allImages.first }
                }
            }
        }
    }
    
    func updateEffect() {
        let context = CIContext()
        DispatchQueue.global(qos: .userInteractive).async {
            let ciImage = CIImage(data: self.imageData)
            let filter = self.mainView.filter
            filter.setValue(ciImage!, forKey: kCIInputImageKey)
            
            if filter.inputKeys.contains("inputRadius") {
                filter.setValue(self.value * 10, forKey: kCIInputRadiusKey)
            }
            if filter.inputKeys.contains("inputIntensity") {
                filter.setValue(self.value, forKey: kCIInputIntensityKey)
            }
            
            guard let newImage = filter.outputImage else { return }
            let cgImage = context.createCGImage(newImage, from: newImage.extent)
            
            DispatchQueue.main.async {
                self.mainView.image = UIImage(cgImage: cgImage! )
            }
        }
    }
    
    func updateImageScale(scale: CGFloat) {
        imageScale = scale
    }
    
    func updateImageRotation(rotation: Double) {
        imageRotation = rotation
    }
}
