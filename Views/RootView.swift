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
    
    private let vm = OnboardringViewModel()
    
    var body: some View {
        TLogo(size: 128)
            .onAppear {
                let profile = profiles.last
                LoginHendeler(router: router,
                              manager: manager,
                              profile: profile)
                .preform(id: profile?.userID,
                         name: "",
                         email: "",
                         brithdate: "",
                         gender: "")
            }
    }
}

#Preview {
    RootView()
}
