//
//  ZoomingCarouselView.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 04/11/25.
//

import SwiftUI

struct ZoomingCarouselView<Content: View>: View {
    // MARK: - Properties
    let itemCount: Int
    @Binding var selectedIndex: Int
    let content: (Int) -> Content
    let imageNames: [String]?

    // Configuration
    var defaultHeight: CGFloat = 250
    private var basePeek: CGFloat = 0.85
    private var maxPeek: CGFloat = 0.90
    var maxScale: CGFloat = 1.0          // Center card scale
    var sideScale: CGFloat = 0.8      // Side cards scale
    var cornerRadius: CGFloat = 16

    // State
    @State private var dragOffset: CGFloat = 0

    // MARK: - Initializer
    init(
        itemCount: Int,
        selectedIndex: Binding<Int>,
        defaultHeight: CGFloat = 250,
        @ViewBuilder content: @escaping (Int) -> Content
    ) {
        self.itemCount = itemCount
        self._selectedIndex = selectedIndex
        self.defaultHeight = defaultHeight
        self.content = content
        self.imageNames = nil
    }
    
    init(
        images: [String],
        selectedIndex: Binding<Int>,
        defaultHeight: CGFloat = 250
    ) where Content == AnyView {
        self.itemCount = images.count
        self._selectedIndex = selectedIndex
        self.defaultHeight = defaultHeight
        self.imageNames = images
        self.content = { index in
            AnyView(EmptyView())
        }
    }

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = max(geometry.size.height, defaultHeight)
            let cardWidth = min(height, width * 0.7) // Card is 70% of screen width

            ZStack {
                ForEach(0..<itemCount, id: \.self) { index in
                    cardView(for: index, cardWidth: cardWidth)
                        .frame(width: cardWidth, height: cardWidth)
                        .cornerRadiusCustom(cornerRadius)
                        .scaleEffect(scaleForCard(at: index, cardWidth: cardWidth))
                        .opacity(opacityForCard(at: index, cardWidth: cardWidth))
                        .offset(x: offsetForCard(at: index, cardWidth: cardWidth))
                        .zIndex(zIndexForCard(at: index, cardWidth: cardWidth))
                        .shadow(
                            color: .black.opacity(shadowOpacity(for: index, cardWidth: cardWidth)),
                            radius: shadowRadius(for: index, cardWidth: cardWidth),
                            x: 0,
                            y: shadowY(for: index, cardWidth: cardWidth)
                        )
                }
            }
            .frame(width: width, height: height)
            .contentShape(Rectangle())
            .animation(.spring(response: 0.35, dampingFraction: 0.82), value: selectedIndex)
            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.86), value: dragOffset)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        handleDragEnd(
                            translation: value.translation.width,
                            predictedTranslation: value.predictedEndTranslation.width,
                            cardWidth: cardWidth
                        )
                    }
            )
            .onAppear {
                if selectedIndex < 0 || selectedIndex >= itemCount {
                    selectedIndex = itemCount / 2
                }
            }
        }
        .frame(minHeight: defaultHeight)
    }
    
    // MARK: - Card View
    
    @ViewBuilder
    private func cardView(for index: Int, cardWidth: CGFloat) -> some View {
        if let imageNames = imageNames, index < imageNames.count {
            Image(imageNames[index])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: cardWidth, height: cardWidth)
                .clipped()
        } else {
            content(index)
        }
    }

    // MARK: - Peek interpolation


    private func currentPeek(for cardWidth: CGFloat) -> CGFloat {
        let progress = min(abs(dragOffset) / (cardWidth == 0 ? 1 : cardWidth), 1.0)
        return basePeek + (maxPeek - basePeek) * progress
    }

    // MARK: - Layout Calculations

    private func offsetForCard(at index: Int, cardWidth: CGFloat) -> CGFloat {
        let spacing = cardWidth * currentPeek(for: cardWidth)
        let dragProgress = dragOffset / (cardWidth * 1.0) // Sensitivity factor
        let effectiveCenter = CGFloat(selectedIndex) - dragProgress

        let relativePosition = CGFloat(index) - effectiveCenter

        let clampedPosition: CGFloat
        if relativePosition < -1.5 {
            clampedPosition = -1.5
        } else if relativePosition > 1.5 {
            clampedPosition = 1.5
        } else {
            clampedPosition = relativePosition
        }

        return clampedPosition * spacing
    }

    private func scaleForCard(at index: Int, cardWidth: CGFloat) -> CGFloat {
        let dragProgress = dragOffset / (cardWidth * 1.0)
        let effectiveCenter = CGFloat(selectedIndex) - dragProgress
        let distanceFromCenter = abs(CGFloat(index) - effectiveCenter)

        if distanceFromCenter <= 1.0 {
            let normalizedDistance = min(distanceFromCenter, 1.0)
            let smoothProgress = (1 - cos(normalizedDistance * .pi)) / 2
            return maxScale - (maxScale - sideScale) * smoothProgress
        } else {
            return sideScale
        }
    }

   // Calculate opacity for each card with smooth fading
    private func opacityForCard(at index: Int, cardWidth: CGFloat) -> Double {
        let dragProgress = dragOffset / (cardWidth * 1.0)
        let effectiveCenter = CGFloat(selectedIndex) - dragProgress
        let distanceFromCenter = abs(CGFloat(index) - effectiveCenter)

        if distanceFromCenter <= 1.0 {
            return 1.0
        } else if distanceFromCenter <= 1.5 {
            let normalizedFade = (distanceFromCenter - 1.0) / 0.5
            let smoothFade = (1 - cos(normalizedFade * .pi)) / 2
            return 1.0 - (smoothFade * 0.25) // Max 25% fade
        } else {
            return 0.75
        }
    }

    private func shadowOpacity(for index: Int, cardWidth: CGFloat) -> Double {
        let dragProgress = dragOffset / (cardWidth * 1.0)
        let effectiveCenter = CGFloat(selectedIndex) - dragProgress
        let distanceFromCenter = abs(CGFloat(index) - effectiveCenter)

        if distanceFromCenter <= 1.0 {
            let smoothProgress = (1 - cos(distanceFromCenter * .pi)) / 2
            return 0.3 - (0.15 * smoothProgress) // 0.3 → 0.15
        } else {
            return 0.15
        }
    }

    private func shadowRadius(for index: Int, cardWidth: CGFloat) -> CGFloat {
        let dragProgress = dragOffset / (cardWidth * 1.0)
        let effectiveCenter = CGFloat(selectedIndex) - dragProgress
        let distanceFromCenter = abs(CGFloat(index) - effectiveCenter)

        if distanceFromCenter <= 1.0 {
            let smoothProgress = (1 - cos(distanceFromCenter * .pi)) / 2
            return 20 - (10 * smoothProgress) // 20 → 10
        } else {
            return 10
        }
    }

    private func shadowY(for index: Int, cardWidth: CGFloat) -> CGFloat {
        let dragProgress = dragOffset / (cardWidth * 1.0)
        let effectiveCenter = CGFloat(selectedIndex) - dragProgress
        let distanceFromCenter = abs(CGFloat(index) - effectiveCenter)

        if distanceFromCenter <= 1.0 {
            let smoothProgress = (1 - cos(distanceFromCenter * .pi)) / 2
            return 10 - (5 * smoothProgress) // 10 → 5
        } else {
            return 5
        }
    }

    private func zIndexForCard(at index: Int, cardWidth: CGFloat) -> Double {
        let dragProgress = dragOffset / (cardWidth * 1.0)
        let effectiveCenter = CGFloat(selectedIndex) - dragProgress
        let relativePosition = CGFloat(index) - effectiveCenter
        let distanceFromCenter = abs(relativePosition)
        
        var zIndex = 100.0 - (distanceFromCenter * 10.0)
        
        // Cards moving towards the back should have lower z-index
        if abs(dragOffset) > 1 {
            let dragDirection = dragOffset > 0 ? 1.0 : -1.0
            if relativePosition * dragDirection > 0 {
                let dragAmount = min(abs(dragProgress), 1.0)
                zIndex -= dragAmount * 5.0
            }
        }
        return zIndex
    }

    // MARK: - Gesture Handling

    private func handleDragEnd(translation: CGFloat, predictedTranslation: CGFloat, cardWidth: CGFloat) {
        let threshold: CGFloat = 50 // Minimum drag to trigger change
        var newIndex = selectedIndex
        if translation < -threshold {
            newIndex = min(selectedIndex + 1, itemCount - 1)
        } else if translation > threshold {
            newIndex = max(selectedIndex - 1, 0)
        }
        withAnimation(.spring(response: 0.35, dampingFraction: 0.82, blendDuration: 0)) {
            selectedIndex = newIndex
            dragOffset = 0
        }
    }
}

// MARK: - Preview Provider
#Preview {
    AtlysLoginView()
}
