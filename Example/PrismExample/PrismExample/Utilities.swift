//
//  Utilities.swift
//  PrismExample
//
//  Created by A. Zheng (github.com/aheze) on 9/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

struct PressedButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool

    func makeBody(configuration: Configuration) -> some View {
        var animation: Animation?

        /// only change when it's different
        if isPressed != configuration.isPressed {
            if configuration.isPressed {
                animation = .spring(
                    response: 0.1,
                    dampingFraction: 0.6,
                    blendDuration: 1
                )
            } else {
                animation = .spring(
                    response: 0.4,
                    dampingFraction: 0.4,
                    blendDuration: 1
                )
            }

            DispatchQueue.main.async {
                withAnimation(animation) {
                    isPressed = configuration.isPressed
                }
            }
        }

        return configuration.label
            .opacity(1) /// needs a modifier to actually be called
    }
}

struct ScalingButtonStyle: ButtonStyle {
    var scale = CGFloat(0.95)
    func makeBody(configuration: Configuration) -> some View {
        var animation: Animation?

        if configuration.isPressed {
            /// pressing down
            animation = .spring(
                response: 0.19,
                dampingFraction: 0.45,
                blendDuration: 1
            )
        } else {
            animation = .spring(
                response: 0.4,
                dampingFraction: 0.4,
                blendDuration: 1
            )
        }

        return configuration.label
            .opacity(configuration.isPressed ? 0.95 : 1)
            .scaleEffect(configuration.isPressed ? scale : 1)
            .animation(animation, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == ScalingButtonStyle {
    static var scaling: ScalingButtonStyle {
        ScalingButtonStyle()
    }

    static func scaling(_ scale: CGFloat) -> ScalingButtonStyle {
        ScalingButtonStyle(scale: scale)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0 ... 1),
            green: .random(in: 0 ... 1),
            blue: .random(in: 0 ... 1),
            alpha: 1.0
        )
    }
}
