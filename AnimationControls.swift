//
//  AnimationControls.swift
//  AnimationSwift
//
//  Created by apprenant74 on 25/10/2025.
//

import SwiftUI

struct AnimationControls: Equatable {
    var delay: Double = 0.0
    var speed: Double = 1.0
    var autoreverses: Bool = true
    var repeatForever: Bool = true
    var repeatCount: Int = 1

    func configuredAnimation(for kind: AnimationKind) -> Animation {
        let base: Animation
        switch kind {
        case .linear:
            base = .linear(duration: 1.0)
        case .easeIn:
            base = .easeIn(duration: 1.0)
        case .easeOut:
            base = .easeOut(duration: 1.2)
        case .easeInOut:
            base = .easeInOut(duration: 1.6)
        case .spring:
            base = .spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.25)
        case .interpolatingSpring:
            base = .interpolatingSpring(stiffness: 70, damping: 6)
        case .bouncy:
            base = .bouncy(duration: 1.0, extraBounce: 0.25)
        case .snappy:
            base = .snappy(duration: 0.4, extraBounce: 0.15)
        }

        var anim = base.delay(delay).speed(speed)

        if repeatForever {
            anim = anim.repeatForever(autoreverses: autoreverses)
        } else {
            anim = anim.repeatCount(repeatCount, autoreverses: autoreverses)
        }

        return anim
    }
}
