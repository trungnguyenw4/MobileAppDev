//
//  BrightButton.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 13/05/2024.
//

import Foundation
import SwiftUI

struct BrightButtonStyle: ButtonStyle {
    var disabled = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(disabled ? .gray : .black)
            .cornerRadius(15)
            .foregroundColor(.white)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.1))
            .contentShape(RoundedRectangle(cornerRadius: 15))

    }
}
