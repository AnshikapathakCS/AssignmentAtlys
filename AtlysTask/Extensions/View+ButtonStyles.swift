//
//  View+ButtonStyles.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 05/11/25.
//

import SwiftUI

// MARK: - Custom Button Style Modifiers

extension View {
    
    // Primary gradient button style
    func primaryButtonStyle(
        height: CGFloat = AppConstants.Dimensions.inputFieldHeight,
        cornerRadius: CGFloat = AppConstants.Dimensions.inputFieldCornerRadius
    ) -> some View {
        self
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(Color(red: 0.48, green: 0.38, blue: 0.88))
            .cornerRadius(cornerRadius)
    }
    
    // Secondary outlined button style
    func secondaryButtonStyle(
        height: CGFloat = AppConstants.Dimensions.inputFieldHeight,
        cornerRadius: CGFloat = AppConstants.Dimensions.inputFieldCornerRadius
    ) -> some View {
        self
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(Color.white)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(AppConstants.Colors.purpleGradientStart, lineWidth: 2)
            )
    }
    
    // Social login button style
    func socialButtonStyle(
        size: CGFloat = AppConstants.Dimensions.socialButtonSize,
        cornerRadius: CGFloat = AppConstants.Dimensions.socialButtonCornerRadius
    ) -> some View {
        self
            .frame(width: size, height: size)
            .background(Color.white)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.04), radius: 3, x: 0, y: 1)
    }
}

// MARK: - Custom ButtonStyle Implementations

// Primary gradient button
struct PrimaryGradientButtonStyle: ButtonStyle {
    let isEnabled: Bool
    
    init(isEnabled: Bool = true) {
        self.isEnabled = isEnabled
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonPrimary()
            .frame(maxWidth: .infinity)
            .frame(height: AppConstants.Dimensions.inputFieldHeight)
            .background(Color(red: 0.48, green: 0.38, blue: 0.88))
            .cornerRadius(AppConstants.Dimensions.inputFieldCornerRadius)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.5)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

// Social login button
struct SocialLoginButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(
                width: AppConstants.Dimensions.socialButtonSize,
                height: AppConstants.Dimensions.socialButtonSize
            )
            .background(Color.white)
            .cornerRadius(AppConstants.Dimensions.socialButtonCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: AppConstants.Dimensions.socialButtonCornerRadius)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.04), radius: 3, x: 0, y: 1)
            .scaleEffect(configuration.isPressed ? 0.93 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Button Extension

extension Button {
    func primaryGradient(isEnabled: Bool = true) -> some View {
        self.buttonStyle(PrimaryGradientButtonStyle(isEnabled: isEnabled))
    }
    
    func socialLogin() -> some View {
        self.buttonStyle(SocialLoginButtonStyle())
    }
}
