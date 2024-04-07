//
//  PaintingAndText.swift
//  PhotoApp
//
//  Created by Тимур Мурадов on 07.04.2024.
//

import SwiftUI
import PencilKit

struct PaintingAndText: View {
    var body: some View {
        PencilKitView()
    }
}

#Preview {
    PaintingAndText()
}

struct PencilKitView: UIViewRepresentable {
    typealias UIViewType = PKCanvasView
    let toolPicker = PKToolPicker()

    func makeUIView(context: Context) -> PKCanvasView {
        let pencilKitCanvasView = PKCanvasView()
        pencilKitCanvasView.drawingPolicy = PKCanvasViewDrawingPolicy.anyInput
        toolPicker.addObserver(pencilKitCanvasView)
        toolPicker.setVisible(true, forFirstResponder: pencilKitCanvasView)
        pencilKitCanvasView.becomeFirstResponder()
        return pencilKitCanvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}
