//
//  ButtonStyle.swift
//  FortniteHome
//
//  Created by Артем Ластович on 20.09.2022.
//

import SwiftUI

struct ScaledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
