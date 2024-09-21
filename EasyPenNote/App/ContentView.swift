//
//  ContentView.swift
//  EasyPenNote
//
//  Created by Edward Nguyen on 18/9/24.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    @State private var canvasView = PKCanvasView()
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            Text("Hello World")
            
            PencilKitCanvasView(canvasView: $canvasView)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("Apple Pencil Note Talking")
        .onAppear(perform: {
            reloadDrawing()
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
    
    func reloadDrawing() {
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
