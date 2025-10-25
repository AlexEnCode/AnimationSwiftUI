//
//  AnimationKind.swift
//  AnimationSwift
//
//  Created by apprenant74 on 25/10/2025.
//

import SwiftUI

enum AnimationKind: CaseIterable, Identifiable {
    case linear, easeIn, easeOut, easeInOut, spring, interpolatingSpring, bouncy, snappy

    var id: Self { self }

    var title: String {
        switch self {
        case .linear: return "Linear"
        case .easeIn: return "Ease In"
        case .easeOut: return "Ease Out"
        case .easeInOut: return "Ease In Out"
        case .spring: return "Spring"
        case .interpolatingSpring: return "Interpolating Spring"
        case .bouncy: return "Bouncy"
        case .snappy: return "Snappy"
        }
    }

    var description: String {
        switch self {
        case .linear: return "Vitesse constante du début à la fin."
        case .easeIn: return "Commence lentement puis accélère."
        case .easeOut: return "Commence vite puis décélère."
        case .easeInOut: return "Lent au début et à la fin, rapide au milieu."
        case .spring: return "Ressort naturel avec rebond doux."
        case .interpolatingSpring: return "Ressort paramétrable : raideur et amortissement."
        case .bouncy: return "Ressort simplifié, rebond fluide (iOS 17+)."
        case .snappy: return "Ressort rapide et nerveux (iOS 17+)."
        }
    }


    func previewModifier(toggle: Bool) -> some ViewModifier {
        switch self {
        case .linear:
            return AnyViewModifier { any in
                AnyView(any.offset(y: toggle ? -16 : 16))
            }
        case .easeIn:
            return AnyViewModifier { any in
                AnyView(any.scaleEffect(toggle ? 1.25 : 0.75))
            }
        case .easeOut:
            return AnyViewModifier { any in
                AnyView(any.opacity(toggle ? 0.25 : 1.0))
            }
        case .easeInOut:
            return AnyViewModifier { any in
                AnyView(any.rotationEffect(.degrees(toggle ? 360 : 0)))
            }
        case .spring:
            return AnyViewModifier { any in
                AnyView(any.offset(y: toggle ? -28 : 28))
            }
        case .interpolatingSpring:
            return AnyViewModifier { any in
                AnyView(any.scaleEffect(toggle ? 1.45 : 0.7))
            }
        case .bouncy:
            return AnyViewModifier { any in
                AnyView(any.offset(x: toggle ? -20 : 20))
            }
        case .snappy:
            return AnyViewModifier { any in
                AnyView(any.rotationEffect(.degrees(toggle ? 12 : -12)))
            }
        }
    }

}
