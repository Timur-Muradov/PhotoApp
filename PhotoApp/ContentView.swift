//
//  ContentView.swift
//  PhotoApp
//
//  Created by Тимур Мурадов on 06.04.2024.
//

import SwiftUI
import CoreImage

struct ContentView: View {
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var filteredImage = UIImage()
    @State private var selectedFilter: FilterType?
    
    let imageFilterService = ImageFilterService()
    
    var body: some View {
        VStack {
            Image(uiImage: self.filteredImage)
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 350)
                .padding()
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom, 20)
            Spacer()
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                    
                    Text("Photo library")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
            Spacer()
            Picker("Select Filter", selection: $selectedFilter) {
                Text("Sepia").tag(FilterType.sepia)
                Text("Vintage").tag(FilterType.vintage)
                Text("Black & White").tag(FilterType.blackAndWhite)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ImageChanged"))) { _ in
            if let selectedFilter = selectedFilter {
                self.filteredImage = self.imageFilterService.applyFilter(to: self.image, filterType: selectedFilter)
            }
        }
    }
}

#Preview {
    ContentView()
}
