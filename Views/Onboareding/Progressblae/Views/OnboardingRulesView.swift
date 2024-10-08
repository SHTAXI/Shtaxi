//
//  OnboardingRulesView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI

struct OnboardingRulesView: OnboardingProgress {    
    internal let onAppear: (() -> ())?
    internal let complition: ((_ enable: Bool) -> ())? = nil
    internal let otherAction: ((any ActionableView) -> ())? = nil
    internal let vm = OnboardringViewModel()
    
    @EnvironmentObject var manager: PersistenceController
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var profiles: FetchedResults<Profile>
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                RightText(text: "ברוך הבא לשטקסי!",
                          font: Custom.shared.font.title)
            }
            HStack {
                Spacer()
                RightText(text: "כמה נקודות חשובות על האפליקציה שלנו",
                          font: Custom.shared.font.textMedium)
            }
            .padding(.bottom, 44)
            
            VStack {
                ruleView(title: "עקרון ראשון",
                         text: "Lorem ipsum dolor sit amet consectetur. Lorem turpis nullam.")
                .padding(.bottom, 20)
                
                ruleView(title: "עקרון שני",
                         text: "Lorem ipsum dolor sit amet consectetur. Lorem turpis nullam.")
                .padding(.bottom, 20)
                
                ruleView(title: "עקרון שלישי",
                         text: "Lorem ipsum dolor sit amet consectetur. Lorem turpis nullam.")
            }
        }
        .onAppear {
            onAppear?()
        }
    }
    
    @ViewBuilder private func ruleView(title: String, text: String) -> some View {
        VStack {
            HStack {
                Spacer()
                Image("bullet")
                    .resizable()
                    .frame(height: 28)
                    .frame(width: 28)
            }
            
            HStack {
                Spacer()
                RightText(text: title,
                          font: Custom.shared.font.textMediumBold)
                .foregroundStyle(Custom.shared.color.darkText)
            }
            
            HStack {
                Spacer()
                RightText(text: text,
                          font: Custom.shared.font.textMedium)
                .foregroundStyle(Custom.shared.color.infoText)
            }
        }
    }
    
    func preformAction(manager: PersistenceController, profile: Profile?, complete: @escaping (_ valid: Bool) -> ()) {
        guard let profile else { return complete(false) }
        vm.upload(id: profile.userID,
                   rules: true, complition: { _ in
            manager.set(profile: profile,
                        rules: true)
            complete(true)
        }, error: { error in
            print(error)
        })
    }
}

//#Preview {
//    OnboardingRulesView {
//        
//    }
//}
