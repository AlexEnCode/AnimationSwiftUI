//
//  AnimationDetailView.swift
//  AnimationSwift
//
//  Created by apprenant74 on 25/10/2025.
//

import SwiftUI


struct AnimationDetailView: View {
    let kind: AnimationKind

    @State private var controls = AnimationControls(delay: 0, speed: 1, autoreverses: true, repeatForever: true, repeatCount: 3)
    @State private var replayID = UUID()

    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                Spacer(minLength: 8)

                AnimatedPreview(kind: kind,
                                animation: controls.configuredAnimation(for: kind),
                                replayID: replayID)
                    .frame(width: 140, height: 140)

                VStack(spacing: 6) {
                    Text(kind.title)
                        .font(.title2).bold()
                    Text(kind.description)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }

                Divider().padding(.horizontal)

                Form {
                    Section("Timing") {
                        HStack {
                            Text("Delay")
                            Spacer()
                            Text(String(format: "%.2fs", controls.delay))
                        }
                        Slider(value: $controls.delay, in: 0...2, step: 0.05)

                        HStack {
                            Text("Speed")
                            Spacer()
                            Text(String(format: "x%.2f", controls.speed))
                        }
                        Slider(value: $controls.speed, in: 0.25...3, step: 0.05)
                    }

                    Section("Repeat") {
                        Toggle("Repeat Forever", isOn: $controls.repeatForever)
                        if !controls.repeatForever {
                            Stepper("Repeat Count: \(controls.repeatCount)", value: $controls.repeatCount, in: 1...20)
                        }
                        Toggle("Auto-reverses", isOn: $controls.autoreverses)
                    }

                    Section {
                        HStack {
                            Button("Rejouer") { replayID = UUID() }
                                .buttonStyle(.borderedProminent)

                            Spacer()

                            Button("Reset") {
                                controls = AnimationControls()
                                replayID = UUID()
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .frame(maxHeight: 340)
            }
            .padding(.top)
            .navigationTitle(kind.title)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: controls) { _ in replayID = UUID() }
        }
    }
}
