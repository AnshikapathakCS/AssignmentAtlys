//
//  AppConstants.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 04/11/25.
//

import SwiftUI

/// Centralized constants for images, text, and UI elements
struct AppConstants {
    
    // MARK: - Image Names
    struct Images {
        static let appLogo = "AtlysLogo"
        static let google = "google"
        static let patternOverlay = "circle.grid.cross.fill"
        
        // Carousel Images
        static let turkey = "Turkey"
        static let paris = "Paris"
        static let istanbul = "Istanbul"
        static let china = "China"
        
        static let carouselImages: [String] = [
            turkey,
            paris,
            istanbul,
            china
        ]
    }
    
    // MARK: - System Icons
    struct SystemIcons {
        static let building = "building.2"
        static let airplane = "airplane.departure"
        static let buildingColumns = "building.columns"
        static let sparkles = "sparkles"
        static let sun = "sun.max"
        static let camera = "camera"
        static let bus = "bus"
        static let appleLogo = "apple.logo"
        static let envelope = "envelope.fill"
        static let checkIcon =  "checkmark.circle.fill"
    }
    
    // MARK: - Text Strings
    struct Text {
        // Header
        static let visasOnTime = "Visas on time"
        
        // Login Section
        static let getVisas = "Get Visas"
        static let onTime = "On Time"
        static let enterMobileNumber = "Enter mobile number"
        static let continueButton = "Continue"
        static let or = "or"
        
        // Social Login
        static let googleLogin = "Google"
        static let appleLogin = "Apple"
        static let emailLogin = "Email"
        
        // Terms & Privacy
        static let termsAgreement = "By continuing, you agree to our"
        static let terms = "terms"
        static let and = "&"
        static let privacyPolicy = "privacy policy"
        static let period = "."
        
        // Card Content
        static let visasOnAtlys = "12K+ Visas on Atlys"
        
        // Country Code
        static let indiaFlag = "🇮🇳"
        static let countryCode = "+91"
    }
    
    // MARK: - Colors
    struct Colors {
        // Light to Dark Purple gradient colors (for buttons)
        static let purpleGradientStart = Color(red: 0.75, green: 0.65, blue: 0.95)  // Light purple
        static let purpleGradientEnd = Color(red: 0.48, green: 0.38, blue: 0.88)    // Dark purple
        
        static var purpleGradient: [Color] {
            [purpleGradientStart, purpleGradientEnd]
        }
        
        // Very light purple gradient colors (for input field backgrounds)
        static let lightPurpleGradientStart = Color(red: 0.95, green: 0.92, blue: 0.99)
        static let lightPurpleGradientEnd = Color(red: 0.88, green: 0.82, blue: 0.98)
        
        static var lightPurpleGradient: [Color] {
            [lightPurpleGradientStart, lightPurpleGradientEnd]
        }
        
        // Disabled button purple gradient colors
        static let disabledPurpleGradientStart = Color(red: 0.85, green: 0.80, blue: 0.95)
        static let disabledPurpleGradientEnd = Color(red: 0.75, green: 0.68, blue: 0.90)
        
        static var disabledPurpleGradient: [Color] {
            [disabledPurpleGradientStart, disabledPurpleGradientEnd]
        }
    }
    
    // MARK: - Destination Data
    struct Destinations {
        static let turkey = CarouselDestination(
            name: "Turkey",
            imageName: Images.turkey
        )
        
        static let paris = CarouselDestination(
            name: "Paris",
            imageName: Images.paris
        )
        
        static let istanbul = CarouselDestination(
            name: "Istanbul",
            imageName: Images.istanbul
        )
        
        static let china = CarouselDestination(
            name: "China",
            imageName: Images.china
        )
        
        static let all: [CarouselDestination] = [
            turkey,
            paris,
            istanbul,
            china
        ]
    }
    
    // MARK: - UI Dimensions
    struct Dimensions {
        // Logo
        static let logoWidth: CGFloat = 120
        static let logoHeight: CGFloat = 60
        
        // Carousel
        static let carouselHeight: CGFloat = 280
        static let defaultCarouselHeight: CGFloat = 200
        
        // Input Fields
        static let inputFieldHeight: CGFloat = 52
        static let inputFieldCornerRadius: CGFloat = 12
        
        // Social Login Buttons
        static let socialButtonSize: CGFloat = 50
        static let socialButtonCornerRadius: CGFloat = 16
        static let socialIconSize: CGFloat = 25
        
        // Spacing
        static let horizontalPadding: CGFloat = 24
        static let bottomPadding: CGFloat = 20
    }
    
    // MARK: - Font Sizes
    struct FontSizes {
        static let headerTitle: CGFloat = 34
        static let caption: CGFloat = 12
        static let body: CGFloat = 17
        static let subheadline: CGFloat = 15
        static let footnote: CGFloat = 13
    }
    
    // MARK: - Animation
    struct Animation {
        static let defaultDuration: CGFloat = 0.3
        static let springResponse: CGFloat = 0.32
        static let springDamping: CGFloat = 0.84
    }
}
