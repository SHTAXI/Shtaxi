//
//  OnboardingChangePhoneView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI
import Combine

struct OnboardingChangePhoneView: ViewWithVM {
    @State private var text: String = ""
    let didType: (_ enable: Bool) -> ()
    private let vm = OnboardringViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                RightText(text: "כניסה עם הנייד",
                          font: Custom.shared.font.title)
            }
            .padding(.bottom, 20)
            HStack {
                TTextFiledView(label: "הכנסת טלפון נייד",
                               text: $text,
                               textColor: .black,
                               keyboardType: .default) { _ in }
                    .onReceive(Just(text)) { _ in
                        didType(!text.isEmpty)
                    }
                    .frame(maxWidth: .infinity)
                Image("phoneIcon")
                    .resizable()
                    .frame(height: 28)
                    .frame(width: 28)
                    .padding(.all, 12)
                    .padding(.leading, 24)
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
    
    func preformAction() {
        vm.upload(phone: text)
    }
}

#Preview {
    OnboardingChangePhoneView { _ in
        
    }
}
