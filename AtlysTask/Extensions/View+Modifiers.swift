//
//  View+Modifiers.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 05/11/25.
//

import SwiftUI

// MARK: - Custom View Modifiers

extension View {
    func cornerRadiusCustom(_ radius: CGFloat) -> some View {
        self.cornerRadius(radius)
    }
}

