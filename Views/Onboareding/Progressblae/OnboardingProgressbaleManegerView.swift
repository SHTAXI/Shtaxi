//
//  OnboardingProgressbaleManegerView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 28/08/2024.
//

import SwiftUI

class OnboardingProgressbaleContentHolder: ObservableObject {
    static var shared = OnboardingProgressbaleContentHolder()
    @Published var content: (any OnboardingProgress)?
    private init(){}
}

struct OnboardingProgressbaleManagerView: ActionableView {
    @EnvironmentObject private var manager: PersistenceController
    @Environment(\.managedObjectContext) private var viewContext
    
    internal let vm = OnboardringViewModel()
    internal let oManager = OnboardingProgressbaleContentHolder.shared
    let screens: [OnboardingProgressbale]
    @Binding var progreesSatge: Int
    @Binding var buttonConfig: TButtonConfig
    let didDone: () -> ()
    let onAppear: (() -> ())?
    let complition: ((_ enable: Bool) -> ())?
    let didSkip: (() -> ())?
    
    var body: some View {
        switch screens[progreesSatge] {
        case .name(let value):
            OnboardingProgressbaleHandelerView<OnboardingNameView>(value: $progreesSatge,
                                                                   total: screens.count,
                                                                   content: .init(text: value,
                                                                                  complition: complition),
                                                                   screen: { screen in oManager.content = screen })
            .environmentObject(manager)
            .environment(\.managedObjectContext, viewContext)
        case .birthdate(let value):
            OnboardingProgressbaleHandelerView<OnboardingBirthdateView>(value: $progreesSatge,
                                                                        total: screens.count,
                                                                        content: .init(date: value,
                                                                                       complition: complition),
                                                                        screen: { screen in oManager.content = screen })
            .environmentObject(manager)
            .environment(\.managedObjectContext, viewContext)
        case .gender(let value):
            OnboardingProgressbaleHandelerView<OnboardingGenderView>(value: $progreesSatge,
                                                                     total: screens.count,
                                                                     content: .init(selectedIndex: value,
                                                                                    complition: complition,
                                                                                    didSkip: didSkip),
                                                                     screen: { screen in oManager.content = screen })
            .environmentObject(manager)
            .environment(\.managedObjectContext, viewContext)
        case .rules:
            OnboardingProgressbaleHandelerView<OnboardingRulesView>(value: $progreesSatge,
                                                                    total: screens.count,
                                                                    content: .init(onAppear: onAppear),
                                                                    screen: { screen in oManager.content = screen })
            .environmentObject(manager)
            .environment(\.managedObjectContext, viewContext)
        }
    }
    
    func preformAction(manager: PersistenceController, profile: Profile, complete: @escaping (_ valid: Bool) -> ()) {
        oManager.content?.preformAction(manager: manager,
                                        profile: profile,
                                        complete: complete)
    }
}

//#Preview {
//    OnboardingProgressbaleManegerView()
//}
