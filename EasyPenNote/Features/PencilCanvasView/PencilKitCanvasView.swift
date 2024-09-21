import SwiftUI
import PencilKit

struct PencilKitCanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    let toolPicker = PKToolPicker()

    // Initial canvas size (can be adjusted later)
    @State private var canvasSize = CGSize(width: 2000, height: 2000)

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: PencilKitCanvasView
        
        init(_ parent: PencilKitCanvasView) {
            self.parent = parent
        }

        // UIScrollViewDelegate method to allow zooming
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return parent.canvasView
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        // Create a UIScrollView
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        
        // Configure the canvas view
        canvasView.backgroundColor = .systemBackground
        canvasView.isOpaque = false
        canvasView.drawingPolicy = .anyInput // Supports both Pencil and finger
        
        // Configure the tool picker
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()

        // Add the canvas view to the scroll view
        scrollView.addSubview(canvasView)
        
        // Set constraints to expand the canvas view's size in the scroll view
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            canvasView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            canvasView.widthAnchor.constraint(equalToConstant: canvasSize.width),
            canvasView.heightAnchor.constraint(equalToConstant: canvasSize.height)
        ])

        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // No updates needed for now
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var canvasView = PKCanvasView()

        var body: some View {
            PencilKitCanvasView(canvasView: $canvasView)
        }
    }
    
    return PreviewWrapper()
}
