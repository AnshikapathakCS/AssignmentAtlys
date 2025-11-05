//
//  View+InputStyles.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 05/11/25.
//

import SwiftUI

// MARK: - Custom Input Field Styles

extension View {
    // Focused input field 
    func focusedInputStyle(
        isFocused: Bool,
        height: CGFloat = AppConstants.Dimensions.inputFieldHeight,
        cornerRadius: CGFloat = AppConstants.Dimensions.inputFieldCornerRadius
    ) -> some View {
        self
            .frame(height: height)
            .background(Color.white)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        isFocused ? Color(red: 0.48, green: 0.38, blue: 0.88) : Color(.systemGray4),
                        lineWidth: isFocused ? 2 : 1.5
                    )
            )
            .shadow(
                color: isFocused ? 
                    Color(red: 0.48, green: 0.38, blue: 0.88).opacity(0.2) : 
                    Color.black.opacity(0.03),
                radius: isFocused ? 4 : 2,
                x: 0,
                y: 1
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

