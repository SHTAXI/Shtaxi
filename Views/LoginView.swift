//
//  ContentView.swift
//  Taxi_MVP
//
//  Created by Barak Ben Hur on 26/06/2024.
//

import SwiftUI
import CoreData
import GoogleSignIn

struct LoginView: ViewWithTransition {
    let transitionAnimation: Bool
    @EnvironmentObject var router: Router
    @EnvironmentObject var manager: PersistenceController
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var profiles: FetchedResults<Profile>
    
    @State private var buttonConfig: TButtonConfig = .defulat(state: .disabled,
                                                              dimantions: .full)
    private let vm = OnboardringViewModel()
    private let holder = Holder<String>()
    @State private var loading = false
    
    private func navigateTo(route: Router.Route) {
        router.navigateTo(route)
    }
    
    var body: some View {
        OnboaredingBaseView(buttonConfig: $buttonConfig,
                            loading: $loading,
                            buttonText: "אישור".localized(),
                            contant: onboardingLoginView()) {
            loading = true
            guard let phone = holder.value else { return loading = false }
            vm.phoneAuth(phone: phone) { verificationID in
                loading = false
                router.navigateTo(.pinCode(phone: phone,
                                           verificationID: verificationID))
            } error: { err in
                loading = false
                guard let err else { return }
                print(err)
            }
        }
                            .environmentObject(manager)
                            .environment(\.managedObjectContext, manager.container.viewContext)
    }
    
    @ViewBuilder private func onboardingLoginView() -> some View {
        OnboardingLoginView { id, name, email, birthdate, gender in
            loading = true
            
            LoginHendeler(router: router,
                          manager: manager,
                          profile:  profiles.last)
            .preform(id: id,
                     name: name ?? "",
                     email: email ?? "",
                     birthdate: birthdate ?? "",
                     gender: gender ?? "") { _ in loading = false }
            
        } didFillPhone: { number in
            holder.value = number
            setButtonConfig(isDone: number.count == 11)
        }
        .environmentObject(manager)
        .environment(\.managedObjectContext, manager.container.viewContext)
    }
    
    private func setButtonConfig(isDone: Bool) {
        withAnimation(.smooth) {
            buttonConfig = .defulat(state: isDone ? .enabled : .disabled,
                                    dimantions: .full)
        }
    }
    
}
