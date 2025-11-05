//
//  ContentView.swift
//  DemoLearning
//
//  Created by Anshika Pathak on 04/11/25.
//

import SwiftUI

// MARK: - ContentView
struct AtlysLoginView: View {
    // MARK: - Properties
    @StateObject private var viewModel = AtlysLoginViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            backgroundView
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    headerView
                    carouselSection
                    loginSection
                }
            }
        }
    }
}

// MARK: - View Components
extension AtlysLoginView {
    // MARK: - Background
    private var backgroundView: some View {
        Color(.systemGroupedBackground)
            .ignoresSafeArea()
    }
    
    // MARK: - Header
    private var headerView: some View {
        VStack(spacing: 4) {
            Image(AppConstants.Images.appLogo, bundle: nil)
                .resizable()
                .frame(
                    width: AppConstants.Dimensions.logoWidth,
                    height: AppConstants.Dimensions.logoHeight
                )
            
            Text(AppConstants.Text.visasOnTime)
                .foregroundColor(Color(AppConstants.Colors.purpleGradient[1]))
                .captionBold()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }
    
    // MARK: - Carousel Section
    private var carouselSection: some View {
        VStack(spacing: 0) {
            ZoomingCarouselView(
                itemCount: viewModel.destinations.count,
                selectedIndex: $viewModel.selectedCarouselIndex,
                defaultHeight: AppConstants.Dimensions.defaultCarouselHeight
            ) { index in
                destinationCardWithOverlay(for: viewModel.destinations[index])
            }
            .frame(height: AppConstants.Dimensions.carouselHeight)
            
            pageIndicatorView
        }
    }
    
    // MARK: - Page Indicator
    private var pageIndicatorView: some View {
        HStack(spacing: 8) {
            ForEach(0..<viewModel.destinations.count, id: \.self) { index in
                Circle()
                    .fill(index == viewModel.selectedCarouselIndex ? Color.primary : Color.secondary)
                    .frame(
                        width: index == viewModel.selectedCarouselIndex ? 10 : 7,
                        height: index == viewModel.selectedCarouselIndex ? 10 : 7
                    )
                    .opacity(index == viewModel.selectedCarouselIndex ? 1 : 0.4)
                    .animation(
                        .easeInOut(duration: AppConstants.Animation.defaultDuration),
                        value: viewModel.selectedCarouselIndex
                    )
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 16)
    }
    
    // MARK: - Login Section
    private var loginSection: some View {
        VStack(spacing: 16) {
            loginTitleView
            
            PhoneInputView(countryFlag: AppConstants.Text.indiaFlag, countryCode: AppConstants.Text.countryCode, placeholder: AppConstants.Text.enterMobileNumber)
            
            orDivider
                .padding(.bottom, 4)
            
            SocialMediaLoginView()
            termsAndPrivacyView
        }
        .padding(.horizontal, AppConstants.Dimensions.horizontalPadding)
        .padding(.bottom, AppConstants.Dimensions.bottomPadding)
    }
    
    // MARK: - Login Title
    private var loginTitleView: some View {
        VStack(spacing: 0) {
            Text(AppConstants.Text.getVisas)
                .headerLarge()
            
            Text(AppConstants.Text.onTime)
                .headerLarge()
        }
        .padding(.bottom, 4)
    }
    
    // MARK: - Or Divider
    private var orDivider: some View {
        HStack(spacing: 16) {
            Rectangle()
                .fill(Color(.systemGray4))
                .frame(height: 1)
            
            Text(AppConstants.Text.or)
                .font(.system(size: AppConstants.FontSizes.subheadline))
                .foregroundColor(.secondary)
            
            Rectangle()
                .fill(Color(.systemGray4))
                .frame(height: 1)
        }
        .padding(.vertical, 4)
    }
    
    // MARK: - Terms and Privacy
    private var termsAndPrivacyView: some View {
        HStack(spacing: 3) {
            Text(AppConstants.Text.termsAgreement)
                .captionRegular()
            
            Button(action: {}) {
                Text(AppConstants.Text.terms)
                    .captionRegular()
                    .linkText()
            }
            
            Text(AppConstants.Text.and)
                .captionRegular()
            
            Button(action: {}) {
                Text(AppConstants.Text.privacyPolicy)
                    .captionRegular()
                    .linkText()
            }
            
            Text(AppConstants.Text.period)
                .captionRegular()
        }
    }
    
    // MARK: - Destination Card with Image Overlay
    @ViewBuilder
    private func destinationCardWithOverlay(for destination: CarouselDestination) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                // Background Image
                Image(destination.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                
                Color.black.opacity(0.2)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: AppConstants.SystemIcons.checkIcon)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 0.48, green: 0.38, blue: 0.88))
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 28, height: 28)
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.black.opacity(0.5), lineWidth: 1)
                            )
                            .padding([.top, .trailing], 10)
                    }
                    .padding()
                    Spacer()
                }
                
                // Text Content
                VStack(alignment: .leading, spacing: 10) {
                    // Country Name
                    Text(destination.name)
                        .displayLarge()
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 2)
                    
                    // 12K+ Visas Badge
                    VStack {
                        Text(AppConstants.Text.visasOnAtlys)
                            .font(.system(size: AppConstants.FontSizes.footnote, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(red: 0.48, green: 0.38, blue: 0.88))
                            .cornerRadiusCustom(14)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                    .padding(.leading, -20)
                }
                .padding(.leading, 10)
                .padding(.bottom, 40)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    AtlysLoginView()
}
