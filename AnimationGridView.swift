//
//  AnimationGridView.swift
//  AnimationSwift
//
//  Created by apprenant74 on 25/10/2025.
//

import SwiftUI
import SwiftUI


struct AnimationGridView: View {
    @State private var selectedKind: AnimationKind? = nil

    private let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(AnimationKind.allCases) { kind in
                        AnimationCell(kind: kind)
                            .onTapGesture { selectedKind = kind }
                    }
                }
                .padding(12)
            }
            .navigationTitle("SwiftUI Animations")
            .sheet(item: $selectedKind) { kind in
                AnimationDetailView(kind: kind)
            }
        }
    }
}
