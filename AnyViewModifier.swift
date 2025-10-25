//
//  AnyViewModifier.swift
//  AnimationSwift
//
//  Created by apprenant74 on 25/10/2025.
//

import SwiftUI

import SwiftUI


struct AnyViewModifier: ViewModifier {
    private let bodyClosure: (AnyView) -> AnyView


    init<V: View>(@ViewBuilder body: @escaping (V) -> V) {
        self.bodyClosure = { anyView in
            if let v = anyView as? V {
                return AnyView(body(v))
            } else {
                return AnyView(body(anyView as! V))
            }
        }
    }

    init(body: @escaping (AnyView) -> AnyView) {
        self.bodyClosure = body
    }

    func body(content: Content) -> some View {
        let any = AnyView(content)
        return bodyClosure(any)
    }
}
