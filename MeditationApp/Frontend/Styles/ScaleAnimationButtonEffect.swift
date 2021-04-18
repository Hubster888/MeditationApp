//
//  ScaleAnimationButtonEffect.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 30/03/2021.
//

import SwiftUI

struct ScaleAnimationButtonEffect: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

