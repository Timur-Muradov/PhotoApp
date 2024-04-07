//
//  ContentView.swift
//  PhotoApp
//
//  Created by Тимур Мурадов on 06.04.2024.
//

import SwiftUI
import CoreImage

struct ContentView: View {
    @StateObject var homeData = HomeViewModel()
    var body: some View {
        NavigationView {
            Home()
                .environmentObject(homeData)
                .navigationTitle("PhotoApp")
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            homeData.updateImageScale(scale: value)
                        })
                .gesture(
                    RotationGesture()
                        .onChanged { value in
                            homeData.updateImageRotation(rotation: value.degrees)
                        })
        }
        PaintingAndText()
    }
}

#Preview {
    ContentView()
}
