//
//  ContentView.swift
//  EasyPenNote
//
//  Created by Edward Nguyen on 18/9/24.
//

import SwiftUI
import PencilKit

struct PencilKitCanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    let toolPicker = PKToolPicker()
    
    func makeUIView(context: Context) -> PKCanvasView {
        // Configure the canvas view
        canvasView.backgroundColor = .systemBackground
        canvasView.isOpaque = false
        canvasView.drawingPolicy = .anyInput // Supports both Pencil and finger
        
        // Configure tool picker
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // No updates needed for now
    }
}


struct ContentView: View {
    @State private var canvasView = PKCanvasView()
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            PencilKitCanvasView(canvasView: $canvasView)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button(action: {
                loadDrawing()
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        }
        .navigationTitle("Apple Pencil Note Talking")
        .onAppear(perform: {
            loadDrawing()
            startAutoSave()
        })
        .onDisappear {
            stopAutoSave()
        }
    }
    
    // Func
    func startAutoSave() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            autosaveDrawing()
        }
    }
    
    func stopAutoSave() {
        timer?.invalidate()
        timer = nil
    }
    
    func autosaveDrawing() {
        let drawing = canvasView.drawing
        if let data = try? drawing.dataRepresentation() {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = url.appendingPathComponent("drawing.drawing")
            try? data.write(to: fileURL)
            print("Drawing autosaved at \(Date())")
        }
    }
    
    func loadDrawing() {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = url.appendingPathComponent("drawing.drawing")
        
        if let data = try? Data(contentsOf: fileURL) {
            let drawing = try? PKDrawing(data: data)
            canvasView.drawing = drawing ?? PKDrawing()
        }
    }
}

#Preview {
    ContentView()
}
