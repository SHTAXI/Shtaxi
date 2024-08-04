//
//  SmsPinCodeView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

struct SmsPinCodeView: ViewWithVM {
    let phone: String
    let didDone: (Bool) -> ()
    
    @State private var pinCode: String = ""
    
    private let vm = OnboardringViewModel()
    
    var body: some View {
        VStack {
            TLogo(size: 64)
                .padding(.bottom, 40)
            HStack {
                Spacer()
                RightText(text: "הכנסת קוד",
                          font: Custom.shared.font.title)
            }
            .padding(.bottom, 4)
            HStack(spacing: 0) {
                Button(action: {
                    
                }, label: {
                    Text("טעות במספר?")
                        .font(Custom.shared.font.button)
                })
                Spacer()
                RightText(text: phone,
                          font: Custom.shared.font.textMediumBold)
                RightText(text: "שלחנו קוד ל",
                          font: Custom.shared.font.textMedium)
            }
            PinCodeView(number: 6) { pinArray in
                pinCode = pinArray.joined()
                didDone(!pinArray.contains(""))
            }
            .padding(.bottom, 20)
            Text("Lorem ipsum dolor sit amet consectetur. Pulvinar sed in dui auctor imperdiet posuere bibendum. Diam sit sed semper.")
                .multilineTextAlignment(.center)
                .font(Custom.shared.font.textSmall)
                .foregroundStyle(Custom.shared.color.infoText)
                .padding(.bottom, 4)
            Button(action: {
                
            }, label: {
                Text("שליחה חוזרת")
                    .font(Custom.shared.font.textMedium)
                    .foregroundStyle(Custom.shared.color.tBlue)
                    .frame(height: 26)
            })
        }
    }
    
    func preformAction() {
        vm.verifayPinCode(code: pinCode)
    }
}

#Preview {
    SmsPinCodeView(phone: "050-2217124") { _ in
        
    }
}
