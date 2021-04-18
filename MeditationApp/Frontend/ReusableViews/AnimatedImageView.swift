//
//  AnimatedImageView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 28/03/2021.
//

import SwiftUI
import FLAnimatedImage

struct AnimatedImageView: UIViewRepresentable {
    let animatedView = FLAnimatedImageView()
    var fileName : String
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        let path : String = Bundle.main.path(forResource: fileName, ofType: "gif")!
        let url = URL(fileURLWithPath:  path)
        let gifData = try! Data(contentsOf: url)
        
        let gif = FLAnimatedImage(animatedGIFData: gifData)
        animatedView.animatedImage = gif
        
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animatedView)
        
        NSLayoutConstraint.activate([
            animatedView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animatedView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
