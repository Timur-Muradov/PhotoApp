//
//  ImageFilterService.swift
//  PhotoApp
//
//  Created by Тимур Мурадов on 06.04.2024.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ImageFilter {
    var name: String
    var filter: CIFilter
}

enum FilterType {
    case sepia
    case vintage
    case blackAndWhite
}

class ImageFilterService {
    let context = CIContext()
    
    func applyFilter(to image: UIImage, filterType: FilterType) -> UIImage {
        guard let ciImage = CIImage(image: image) else { return image }
        
        switch filterType {
        case .sepia:
            let filter = CIFilter.sepiaTone()
            filter.inputImage = ciImage
            return applyFilter(filter)
        case .vintage:
            let filter = CIFilter.photoEffectProcess()
            filter.inputImage = ciImage
            return applyFilter(filter)
        case .blackAndWhite:
            let filter = CIFilter.colorMonochrome()
            filter.inputImage = ciImage
            return applyFilter(filter)
        }
    }
    
    private func applyFilter(_ filter: CIFilter) -> UIImage {
        guard let outputCIImage = filter.outputImage else { return UIImage() }
        guard let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return UIImage() }
        return UIImage(cgImage: outputCGImage)
    }
}
