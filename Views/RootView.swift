//
//  RootView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 28/06/2024.
//

import SwiftUI

struct RootView: ViewWithTransition {
    let transitionAnimation: Bool = false
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var manager: PersistenceController
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var profiles: FetchedResults<Profile>
    
    @State private var logoSize = CGSize(width: 1,
                                     height: 1)
    @State private var logoOpticity = 1.00
    
    private let vm = OnboardringViewModel()
    
    var body: some View {
        TLogo(shape: Rectangle(),
              size: 128)
        .scaleEffect(logoSize,
                     anchor: .center)
        .opacity(logoOpticity)
        .navigationBarBackButtonHidden()
        .onAppear {
            withAnimation(.interactiveSpring(duration: 1.5).repeatForever(autoreverses: true)) {
                logoSize.width = 1.4
                logoSize.height = 1.4
                logoOpticity = 0.6
            }
            
            let profile = profiles.last
            LoginHendeler(router: router,
                          manager: manager,
                          profile: profile)
            .preform(id: profile?.userID,
                     name: "",
                     email: "",
                     birthdate: "",
                     gender: "")
        }
    }
}

