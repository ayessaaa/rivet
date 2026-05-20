//
//  CircularProgressView.swift
//  Rivet
//
//  Created by yessa on 5/20/26.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double // 0.0 to 1.0
    let width: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 7)
                .opacity(0.3)
                .foregroundColor(.gray)
                .frame(width: width)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: 270.0)) // Start from top
                .animation(.linear, value: progress) // Smooth transition
                .frame(width: width)
        }
        .padding(10)
    }
}


#Preview {
    CircularProgressView(progress: 0.4, width: 50)
}
