//
//  OnboardingProgressbaleManegerView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

enum OnboardingProgressbale: Codable, Hashable {
    case name(value: String), birthdate(value: String), gender(value: Int?), rules
}

struct OnboardingProgressbaleHandelerView<Content: OnboardingProgress>: ActionableView {
    @EnvironmentObject var manager: PersistenceController
    @Environment(\.managedObjectContext) private var viewContext
    
    internal let vm: OnboardringViewModel? = nil
    @Binding var value: Int
    let total: Int
    let content: Content?
    let screen: (Content) -> ()
    
    var body: some View {
        if let content {
            OnboardingProgressbaleView(value: $value,
                                       total: total,
                                       contant: content)
            .onAppear {
                screen(content)
            }
            .environmentObject(manager)
            .environment(\.managedObjectContext, viewContext)
        }
    }
    
    func preformAction(manager: PersistenceController, profile: Profile?, complete: @escaping (_ valid: Bool) -> ()) {
        content?.preformAction(manager: manager,
                               profile: profile, 
                               complete: complete)
    }
}

//#Preview {
//    OnboardingProgressbaleManegerView(value: .constant(0),
//                                      screens: [.rules, .birthdate, .gender, .rules]) { enable in
//
//    }
//}
