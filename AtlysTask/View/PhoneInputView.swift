//
//  PhoneInputView.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 04/11/25.
//

import SwiftUI

struct PhoneInputView: View {
    // MARK: - Static UI Properties
    let countryFlag: String
    let countryCode: String
    let placeholder: String

    var body: some View {
        VStack(spacing: 16) {
            phoneInputField
            continueButton
        }
    }

    // MARK: - Phone Input Field (Design Only)
    private var phoneInputField: some View {
        HStack(spacing: 0) {
            countryCodeView

            Divider()
                .frame(height: 20)
                .padding(.trailing, 10)

            Text(placeholder)
                .bodyRegular()
                .foregroundColor(.secondary)
                .padding(.trailing, 14)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .focusedInputStyle(isFocused: false)
    }

    // MARK: - Country Code
    private var countryCodeView: some View {
        HStack(spacing: 6) {
            Text(countryFlag)
                .bodyRegular()

            Text(countryCode)
                .bodySemibold()
        }
        .padding(.horizontal, 14)
    }

    // MARK: - Continue Button (Design Only)
    private var continueButton: some View {
        Button(action: {}) {
            Text(AppConstants.Text.continueButton)
                .buttonPrimary()
        }
        .primaryGradient(isEnabled: true)
    }
}

// MARK: - Preview
#Preview {
    PhoneInputView(
        countryFlag: AppConstants.Text.indiaFlag,
        countryCode: AppConstants.Text.countryCode,
        placeholder: AppConstants.Text.enterMobileNumber
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
