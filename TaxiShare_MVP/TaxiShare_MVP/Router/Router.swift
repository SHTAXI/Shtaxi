//
//  Coordinator.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 28/06/2024.
//

import SwiftUI

enum OnboaredingType: Codable, Hashable {
    case login, pinCode(phone: String), progressbale(screens: [OnboardingProgressbale])
}


class Router: ObservableObject {
    // Contains the possible destinations in our Router
    enum Route: Codable, Hashable {
        case login
        case onboarding(type: OnboaredingType)
        case map
        case filter
    }
    
    // Used to programatically control our navigation stack
    @Published var path: NavigationPath = NavigationPath()
    
    // Builds the views
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .login:
            OnboardingManegerView(type: .login) {
                
            } didLogin: { [weak self] type, name, email in
                guard let self else { return }
                
            }
            .navigationBarBackButtonHidden()
        case .onboarding(let type):
            OnboardingManegerView(type: type) { [weak self] in
                guard let self else { return }
                navigateTo(.map)
                
            } didLogin: { [weak self] type, name, email in
                guard let self else { return }
                switch type {
                case .apple, .google, .facebook:
                    var screens: [OnboardingProgressbale] = []
                    if let name, !name.isEmpty {
                        screens.append(.name)
                    }
                    screens.append(contentsOf: [.birthdate, .gender, .rules])
                    navigateTo(.onboarding(type: .progressbale(screens: screens)))
                case .phone(let number):
                    navigateTo(.onboarding(type: .pinCode(phone: number)))
                }
            }
            .navigationBarBackButtonHidden()
        case .map:
            MapView()
                .navigationBarBackButtonHidden()
        case .filter:
            FilterView()
        }
    }
    
    // Used by views to navigate to another view
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    // Used to go back to the previous screen
    func navigateBack() {
        path.removeLast()
    }
    
    // Pop to the root screen in our hierarchy
    func popToRoot() {
        path.removeLast(path.count)
    }
}
