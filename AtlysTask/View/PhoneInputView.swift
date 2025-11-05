//
//  PhoneInputView.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 04/11/25.
//

import SwiftUI

// MARK: - Phone Input View
struct PhoneInputView: View {
    // MARK: - Properties
    @Binding var phoneNumber: String
    @Binding var isValid: Bool
    let countryFlag: String
    let countryCode: String
    let placeholder: String
    let onContinue: () -> Void
    
    @FocusState private var isFocused: Bool
    
    // MARK: - Initializer
    init(
        phoneNumber: Binding<String>,
        isValid: Binding<Bool> = .constant(true),
        countryFlag: String = AppConstants.Text.indiaFlag,
        countryCode: String = AppConstants.Text.countryCode,
        placeholder: String = AppConstants.Text.enterMobileNumber,
        onContinue: @escaping () -> Void
    ) {
        self._phoneNumber = phoneNumber
        self._isValid = isValid
        self.countryFlag = countryFlag
        self.countryCode = countryCode
        self.placeholder = placeholder
        self.onContinue = onContinue
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            phoneInputField
            continueButton
        }
    }
}

// MARK: - View Components
extension PhoneInputView {
    // MARK: - Phone Input Field
    private var phoneInputField: some View {
        HStack(spacing: 0) {
            countryCodeView
            
            Divider()
                .frame(height: 20)
                .padding(.trailing, 10)
            
            TextField(placeholder, text: $phoneNumber)
                .bodyRegular()
                .keyboardType(.numberPad)
                .focused($isFocused)
                .padding(.trailing, 14)
                .onChange(of: phoneNumber) { newValue in
                    if newValue.count > 10 {
                        phoneNumber = String(newValue.prefix(10))
                    }
                }
        }
        .focusedInputStyle(isFocused: isFocused)
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
    
    // MARK: - Continue Button
    private var continueButton: some View {
        Button(action: onContinue) {
            Text(AppConstants.Text.continueButton)
                .buttonPrimary()
        }
        .primaryGradient(isEnabled: isValid)
        .disabled(!isValid)
    }
}

// MARK: - Preview
#Preview {
    PhoneInputView(
        phoneNumber: .constant(""),
        onContinue: {
            print("Continue tapped")
        }
    )
    .padding()
}

