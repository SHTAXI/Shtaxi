//
//  OnboardingProgressbaleBaseView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 28/08/2024.
//

import SwiftUI

struct OnboardingProgressbaleContainerView: ViewWithTransition {
    let transitionAnimation: Bool
    @EnvironmentObject private var manager: PersistenceController
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var profiles: FetchedResults<Profile>
    @EnvironmentObject var router: Router
    
    @State internal var progreesSatge: Int = 0
    @State internal var loading = false
    internal let vm = OnboardringViewModel()
    
    let screens: [OnboardingProgressbale]
    @State private var buttonConfig: TButtonConfig = .defulat(state: .disabled,
                                                              dimantions: .full)
    
    var body: some View {
        if progreesSatge < screens.count {
            let buttonText =  progreesSatge < screens.count - 1 ? "אישור".localized() : "שנצא לדרך?".localized()
            let content = progreesView(screens: screens)
            
            OnboaredingBaseView(buttonConfig: $buttonConfig,
                                loading: $loading,
                                buttonText: buttonText,
                                contant: content) { preformAction(content: content) }
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
        }
    }
    
    @ViewBuilder private func progreesView(screens: [OnboardingProgressbale]) -> some ActionableView {
        OnboardingProgressbaleManagerView(screens: screens,
                                          progreesSatge: $progreesSatge,
                                          buttonConfig: $buttonConfig,
                                          didDone: { router.navigateTo(.map) },
                                          onAppear: { setButtonConfig(isDone: true) },
                                          complition: { isDone in setButtonConfig(isDone: isDone) },
                                          otherAction: { content in preformAction(content: content) })
    }
    
    private func preformAction(content: any ActionableView) {
        loading = true
        
        guard let profile = profiles.last else {
            loading = false
            return
        }
        
        content.preformAction(manager: manager,
                              profile: profile) { valid in
            loading = false
            guard valid else { return }
            approveProgress()
        }
    }
    
    private func setButtonConfig(isDone: Bool) {
        withAnimation(.smooth) {
            buttonConfig = .defulat(state: isDone ? .enabled : .disabled,
                                    dimantions: .full)
        }
    }
    
    private func approveProgress() {
        guard progreesSatge == screens.count - 1 else {
            withAnimation(.smooth) { progreesSatge += 1 }
            return setButtonConfig(isDone: false)
        }
        router.navigateTo(.map)
    }
}

//#Preview {
//    OnboardingProgressbaleBaseView()
//}
