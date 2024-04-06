//
//  ImageFilterService.swift
//  PhotoApp
//
//  Created by Тимур Мурадов on 06.04.2024.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class ImageFilterService {
    
    let context = CIContext()
    let filter = CIFilter.sepiaTone()
    
    func applySepiaTone(to image: UIImage) -> UIImage {
        guard let ciImage = CIImage(image: image) else { return image }
        
        filter.inputImage = ciImage
        filter.intensity = 0.8 // Устанавливаем интенсивность эффекта сепии
        
        guard let outputCIImage = filter.outputImage else { return image }
        guard let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return image }
        
        return UIImage(cgImage: outputCGImage)
    }
}
