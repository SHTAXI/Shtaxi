//
//  OnboardingNameView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI
import Combine

struct OnboardingNameView: ViewWithVM {
    @State private var text: String = ""
    let didType: (_ enable: Bool) -> ()
    private let vm = OnboardringViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                RightText(text: "מה השם שלך?",
                          font: Custom.shared.font.title)
            }
            .padding(.bottom, 20)
            TTextFiledView(label: "הכנסת שם פרטי",
                           text: $text, 
                           textColor: .black,
                           keyboardType: .default) { _ in }
                .onReceive(Just(text)) { _ in
                    didType(!text.isEmpty)
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
        vm.upload(name: text)
    }
}

#Preview {
    OnboardingNameView { enable in
        
    }
}
