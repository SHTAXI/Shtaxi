//
//  LoginPhoneView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 08/08/2024.
//

import SwiftUI
import Combine

struct LoginPhoneView: View {
    @State private var text: String = ""
    let didType: (_ phone: String) -> ()
    
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
                TTextFiledView(label: "הכנסת טלפון נייד",
                               text: $text,
                               textColor: Custom.shared.color.black,
                               keyboardType: .numberPad,
                               textAlignment: .trailing) { _ in }
                    .onReceive(Just(text)) { _ in
                        text.formatPhone()
                        text.limitText(11)
                        didType(text)
                    }
            }
            .padding(.trailing, 24)
            ZStack {
                Custom.shared.color.black
            }
            .frame(height: 1)
            .padding(.bottom, 19)
            Text("Lorem ipsum dolor sit amet consectetur. Pulvinar sed in dui auctor imperdiet posuere bibendum. Diam sit sed semper.")
                .multilineTextAlignment(.center)
                .font(Custom.shared.font.textSmall)
                .foregroundStyle(Custom.shared.color.infoText)
        }
    }
}

#Preview {
    LoginPhoneView { _ in
        
    }
}
