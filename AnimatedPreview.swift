//
//  AnimatedPreview.swift
//  AnimationSwift
//
//  Created by apprenant74 on 25/10/2025.
//

import SwiftUI

struct AnimatedPreview: View {
    let kind: AnimationKind
    let animation: Animation
    let replayID: UUID

    @State private var active = false

    var body: some View {
        Image(systemName: "swift")
            .resizable()
            .scaledToFit()
            .foregroundColor(Color(.systemBlue))
            .modifier(kind.previewModifier(toggle: active))
            .id(replayID)
            .onAppear {
                active = false
                withAnimation(animation) { active.toggle() }
            }
            .onChange(of: replayID) { _ in
                active = false
                withAnimation(animation) { active.toggle() }
            }
    }
}
