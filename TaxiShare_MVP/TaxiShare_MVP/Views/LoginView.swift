//
//  ContentView.swift
//  Taxi_MVP
//
//  Created by Barak Ben Hur on 26/06/2024.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @FetchRequest(sortDescriptors: []) private var profile: FetchedResults<Profile>
    @EnvironmentObject var router: Router
    
    private func navigateTo(route: Router.Route) {
        router.navigateTo(route)
    }
    
    var body: some View {
        OnboardingManegerView(type: .login) {
            
        } didLogin: { rype, name, email in
            
        }
    }
}

#Preview {
    LoginView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(Router())
}
