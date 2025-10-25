//
//  AnimationCell.swift
//  AnimationSwift
//
//  Created by apprenant74 on 25/10/2025.
//

import SwiftUI


struct AnimationCell: View {
    let kind: AnimationKind

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
                .shadow(color: Color.black.opacity(0.06), radius: 2, x: 0, y: 1)

            VStack(spacing: 8) {
                InlinePreview(kind: kind)
                    .frame(width: 56, height: 56)
                Text(kind.title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.primary)
            }
            .padding(8)
        }
        .frame(minHeight: 110)
    }
}


struct InlinePreview: View {
    let kind: AnimationKind
    @State private var toggle = false

    var body: some View {
        let controls = AnimationControls()
        let anim = controls.configuredAnimation(for: kind)

        Image(systemName: "swift")
            .resizable()
            .scaledToFit()
            .foregroundColor(Color(.systemBlue))
            .modifier(kind.previewModifier(toggle: toggle))
            .onAppear {
                withAnimation(anim) { toggle.toggle() }
            }
    }
}
