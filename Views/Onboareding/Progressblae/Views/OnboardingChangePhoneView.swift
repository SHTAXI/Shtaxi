//
//  OnboardingChangePhoneView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI
import Combine

struct OnboardingChangePhoneView: ActionableView {
    @State private var text: String = ""
    let didType: (_ enable: Bool) -> ()
    internal let vm: OnboardringViewModel? = OnboardringViewModel()
    
    @FetchRequest(entity: Profile.entity(),  sortDescriptors: []) var profiles: FetchedResults<Profile>
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                RightText(text: "כניסה עם הנייד",
                          font: Custom.shared.font.title)
            }
            .padding(.bottom, 20)
            HStack {
                Image("phoneIcon")
                    .resizable()
                    .frame(height: 28)
                    .frame(width: 28)
                    .padding(.all, 12)
                    .padding(.leading, 24)
                TTextFiledView(label: "הכנסת טלפון נייד",
                               text: $text,
                               textColor: .black,
                               keyboardType: .default, 
                               textAlignment: .trailing) { _ in }
                    .onReceive(Just(text)) { _ in
                        didType(!text.isEmpty)
                    }
                    .frame(maxWidth: .infinity)
            }
            ZStack {
                Color.black
            }
            .frame(height: 1)
            .padding(.bottom, 19)
            Text("Lorem ipsum dolor sit amet consectetur. Pulvinar sed in dui auctor imperdiet posuere bibendum. Diam sit sed semper.")
                .multilineTextAlignment(.center)
                .font(Custom.shared.font.textSmall)
                .foregroundStyle(Custom.shared.color.infoText)
        }
    }
    
    func preformAction(manager: PersistenceController, profile: Profile, complete: @escaping (_ valid: Bool) -> ()) {
        vm?.upload(id: profile.userID,
                   phone: text) { _ in
            complete(true)
        } error: { error in
            print(error)
        }
    }
}

#Preview {
    OnboardingChangePhoneView { _ in
        
    }
}
