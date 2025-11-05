//
//  AtlysLoginViewModel.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 05/11/25.
//

import Foundation

final class AtlysLoginViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedCarouselIndex: Int = 1
    @Published var phoneNumber: String = "" {
        didSet {
            isPhoneNumberValid = validatePhoneNumber(phoneNumber)
        }
    }
    @Published var isPhoneNumberValid: Bool = false
    
    // MARK: - Properties
    let destinations: [CarouselDestination]
    
    // MARK: - Validation Constants
    private let minPhoneNumberLength = 10
    private let maxPhoneNumberLength = 10
    
    // MARK: - Initialization
    init(destinations: [CarouselDestination] = AppConstants.Destinations.all) {
        self.destinations = destinations
    }
    
    // MARK: - Private Methods
    
    // Validates phone number format
  
    private func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        let trimmed = phoneNumber.trimmingCharacters(in: .whitespaces)
        
        // Check length
        guard trimmed.count >= minPhoneNumberLength,
              trimmed.count <= maxPhoneNumberLength else {
            return false
        }
        
        let isNumeric = trimmed.allSatisfy { $0.isNumber }
        
        return isNumeric
    }
    
}
