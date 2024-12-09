//
//  LoadingView.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    fileprivate var configuration = { (indicator: UIView) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}

extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView)->Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isLoading: Bool
    var content: () -> Content
    let color1 = Color.gray.opacity(0.7)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isLoading)
//                    .blur(radius: self.isLoading ? 3 : 0)
                
                VStack {
                    Text("Loading...")
                        .padding(10)
                        .foregroundColor(.gray.opacity(0.7))
                    ActivityIndicator(isAnimating: isLoading)
                        .configure { $0.color = UIColor(color1)}
                        .padding(.bottom, 10)
                }
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(5)
                .opacity(self.isLoading ? 1 : 0)
            }
        }
    }
}
