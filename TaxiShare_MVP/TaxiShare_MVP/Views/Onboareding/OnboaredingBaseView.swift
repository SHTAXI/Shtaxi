//
//  OnboaredingBaseView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

struct OnboaredingBaseView<Contant: View>: View where Contant: ViewWithVM {
    @Binding var buttonConfig: TButtonConfig
    let buttonText: String
    let contant: Contant
    let didApprove: () -> ()
    
    var body: some View {
        VStack {
            contant
            Spacer()
            TButton(text: buttonText,
                    config: buttonConfig) {
                didApprove()
                contant.preformAction()
            }
        }
        .padding(.top, 68)
        .padding(.bottom, 72)
        .padding(.horizontal, 40)
        .ignoresSafeArea()
    }
}

#Preview {
    OnboaredingBaseView(
        buttonConfig: .constant(.defulat(state: .disabled,
                                         dimantions: .full)),
        buttonText: "אישור",
        contant: SmsPinCodeView(phone: "") { _ in
            
        }
    ) {
        
    }
}
