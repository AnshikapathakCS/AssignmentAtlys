//
//  View+TextStyles.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 05/11/25.
//

import SwiftUI

// MARK: - Custom Text Style Modifiers

//Extension providing reusable text style modifiers following Design System principles
extension View {
    
    // MARK: - Header Styles
    
    func displayLarge() -> some View {
        self.modifier(TextStyleModifier(
            size: 36,
            weight: .bold,
            color: .white
        ))
    }
    
    func headerLarge() -> some View {
        self.modifier(TextStyleModifier(
            size: 34,
            weight: .bold,
            color: .primary
        ))
    }
    
    
    // MARK: - Body Styles
    
    //Regular body text (17pt, regular)
    func bodyRegular() -> some View {
        self.modifier(TextStyleModifier(
            size: 17,
            weight: .regular,
            color: .primary
        ))
    }
    
    //Medium body text (17pt, medium)
    func bodyMedium() -> some View {
        self.modifier(TextStyleModifier(
            size: 17,
            weight: .medium,
            color: .primary
        ))
    }
    
    //Semibold body text (17pt, semibold)
    func bodySemibold() -> some View {
        self.modifier(TextStyleModifier(
            size: 17,
            weight: .semibold,
            color: .primary
        ))
    }
    
    // MARK: - Button Styles
    
    //Primary button text style (17pt, semibold, white)
    func buttonPrimary() -> some View {
        self.modifier(TextStyleModifier(
            size: 17,
            weight: .semibold,
            color: .white
        ))
    }
    
    //Secondary button text style (17pt, medium)
    func buttonSecondary() -> some View {
        self.modifier(TextStyleModifier(
            size: 17,
            weight: .medium,
            color: .primary
        ))
    }
    
    // MARK: - Caption Styles
    
    //Regular caption (12pt, regular)
    func captionRegular() -> some View {
        self.modifier(TextStyleModifier(
            size: 12,
            weight: .regular,
            color: .secondary
        ))
    }
    
    
    //Bold caption (12pt, bold)
    func captionBold() -> some View {
        self.modifier(TextStyleModifier(
            size: 12,
            weight: .bold,
            color: nil
        ))
    }
    
    // MARK: - Special Styles
    
    //Link text style (underlined, primary color)
    func linkText() -> some View {
        self
            .underline()
            .foregroundColor(.primary)
    }

}

// MARK: - Text Style Modifier

//Reusable ViewModifier for consistent text styling
private struct TextStyleModifier: ViewModifier {
    let size: CGFloat
    let weight: Font.Weight
    let color: Color?
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight))
            .foregroundColor(color ?? .primary)
    }
}
