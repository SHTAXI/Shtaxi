//
//  RootView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 28/06/2024.
//

import SwiftUI

struct RootView: View {
    @FetchRequest(sortDescriptors: []) private var profile: FetchedResults<Profile>
    
    var body: some View {
        if profile.isEmpty {
            LoginView()
            //            OnboardingManegerView(type: .progressbale(screens: [.name, .birthdate, .gender, .rules])) {
            //
            //            }
        }
        else {
            MapView()
        }
    }
}

#Preview {
    RootView()
}
