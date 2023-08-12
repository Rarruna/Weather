import SwiftUI

struct UIPreviewView<V: UIView>: UIViewRepresentable {
    
    private let view: V
    
    init(_ view: V) {
        self.view = view
    }
    
    func makeUIView(context: Context) -> V {
        return view
    }
    
    func updateUIView(_ uiView: V, context: Context) { }
}
