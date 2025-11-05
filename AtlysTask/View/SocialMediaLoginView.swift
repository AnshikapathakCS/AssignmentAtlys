//
//  SocialMediaLoginView.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 04/11/25.
//

import SwiftUI

// MARK: - Social Media Login View
struct SocialMediaLoginView: View {

    // MARK: - Body
    var body: some View {
        HStack(spacing: 18) {
            self.googleLoginButton
            self.appleLoginButton
            self.emailLoginButton
        }
    }
}

// MARK: - View Components
extension SocialMediaLoginView {
    // MARK: - Google Login Button
    private var googleLoginButton: some View {
        Button(action: {}) {
            Image(AppConstants.Images.google, bundle: nil)
                .resizable()
                .frame(
                    width: AppConstants.Dimensions.socialIconSize,
                    height: AppConstants.Dimensions.socialIconSize
                )
        }
        .socialLogin()
    }
    
    // MARK: - Apple Login Button
    private var appleLoginButton: some View {
        Button(action: {}) {
            Image(systemName: AppConstants.SystemIcons.appleLogo)
                .font(.system(size: 30, weight: .medium))
                .foregroundColor(.black)
        }
        .socialLogin()
    }
    
    // MARK: - Email Login Button
    private var emailLoginButton: some View {
        Button(action: {}) {
            Image(systemName: AppConstants.SystemIcons.envelope)
                .font(.system(size: 28))
                .foregroundColor(.black)
        }
        .socialLogin()
    }
}

// MARK: - Preview
#Preview {
    SocialMediaLoginView()
    .padding()
}

