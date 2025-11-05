//
//  CarouselViewModel.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 05/11/25.
//

import Foundation

final class CarouselViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedIndex: Int
    @Published var dragOffset: CGFloat = 0
    @Published var isUserInteracting: Bool = false
    
    // MARK: - Properties
    let itemCount: Int
    private var autoScrollTimer: Timer?
    private let autoScrollInterval: TimeInterval = 3.0
    private let autoScrollEnabled: Bool
    
    // MARK: - Initialization
    
    init(
        itemCount: Int,
        initialIndex: Int = 0,
        autoScrollEnabled: Bool = false
    ) {
        self.itemCount = itemCount
        self.selectedIndex = max(0, min(initialIndex, itemCount - 1))
        self.autoScrollEnabled = autoScrollEnabled
        
        if autoScrollEnabled {
            startAutoScroll()
        }
    }
    
    deinit {
        stopAutoScroll()
    }
    
    // MARK: - Public Methods
    
    // Moves to the next carousel item
    func moveToNext() {
        guard selectedIndex < itemCount - 1 else { return }
        selectedIndex += 1
    }
    
    // Moves to the previous carousel item
    func moveToPrevious() {
        guard selectedIndex > 0 else { return }
        selectedIndex -= 1
    }
    
   
    func handleDragEnd(translation: CGFloat, cardWidth: CGFloat) {
        let threshold: CGFloat = 50
        
        if translation < -threshold {
            moveToNext()
        } else if translation > threshold {
            moveToPrevious()
        }
        
        dragOffset = 0
        isUserInteracting = false
        
        if autoScrollEnabled {
            startAutoScroll()
        }
    }
    
    // MARK: - Private Methods
    
    // Starts the auto-scroll timer
    private func startAutoScroll() {
        guard autoScrollTimer == nil else { return }
        
        autoScrollTimer = Timer.scheduledTimer(
            withTimeInterval: autoScrollInterval,
            repeats: true
        ) { [weak self] _ in
            self?.autoScroll()
        }
    }
    
    // Stops the auto-scroll timer
    private func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    // Performs auto-scroll action
    private func autoScroll() {
        guard !isUserInteracting else { return }
        
        if selectedIndex < itemCount - 1 {
            selectedIndex += 1
        } else {
            selectedIndex = 0 // Loop back to start
        }
    }
}
