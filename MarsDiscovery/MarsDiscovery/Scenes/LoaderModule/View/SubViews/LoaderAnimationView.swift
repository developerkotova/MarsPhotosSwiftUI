//
//  LoaderAnimationView.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 12.07.2024.
//

import SwiftUI
import Lottie
import SnapKit

struct LoaderAnimationView: UIViewRepresentable {
    var filename: String
    
    func makeUIView(context: UIViewRepresentableContext<LoaderAnimationView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LoaderAnimationView>) {}
}
