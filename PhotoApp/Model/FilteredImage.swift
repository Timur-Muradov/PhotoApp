//
//  FilteredImage.swift
//  PhotoApp
//
//  Created by Тимур Мурадов on 07.04.2024.
//

import SwiftUI
import CoreImage

struct FilteredImage: Identifiable {
    var id = UUID().uuidString
    var image: UIImage
    var filter: CIFilter
    var isEditable: Bool
}
