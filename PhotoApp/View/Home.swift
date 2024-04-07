//
//  Home.swift
//  PhotoApp
//
//  Created by Тимур Мурадов on 07.04.2024.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    var body: some View {
        
        VStack {
            if !homeData.allImages.isEmpty && homeData.mainView != nil {
                Image(uiImage: homeData.mainView.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                    .scaleEffect(homeData.imageScale)
                    .rotationEffect(Angle(degrees: homeData.imageRotation))
                
                Slider(value: $homeData.value)
                    .padding()
                    .opacity(homeData.mainView.isEditable ? 1 : 0)
                    .disabled(homeData.mainView.isEditable ? false : true)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(homeData.allImages) { filtered in
                            Image(uiImage: filtered.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150)
                                .onTapGesture {
                                    homeData.value = 1.0
                                    homeData.mainView = filtered
                                }
                        }
                    }
                    .padding()
                }
            }
            else if homeData.imageData.count == 0 {
                Text("Выберете картинку")
            }
            else {
                
            }
        }
        .onChange(of: homeData.value) { (_) in
            homeData.updateEffect()
        }
        .onChange(of: homeData.imageData, perform: {  (_) in
            homeData.allImages.removeAll()
            homeData.mainView = nil
            homeData.loadFilter()
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { homeData.imagePicker.toggle() }) {
                    Image(systemName: "photo")
                        .font(.title2)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    UIImageWriteToSavedPhotosAlbum(homeData.mainView.image, nil, nil, nil)
                }) {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title2)
                }
                disabled(homeData.mainView == nil ? true : false)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                }
                .disabled(homeData.mainView == nil ? true : false)
            }
        }
            .sheet(isPresented: $homeData.imagePicker) {
                ImagePicker(picker: $homeData.imagePicker, imageData: $homeData.imageData)
            }
        }
    }
    
    #Preview {
        Home()
    }