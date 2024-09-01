//
//  OnboaredingBaseView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

struct OnboaredingBaseView<Contant: View>: View {
    @EnvironmentObject private var manager: PersistenceController
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var buttonConfig: TButtonConfig
    @Binding var loading: Bool
    let buttonText: String
    let contant: Contant
    let didApprove: () -> ()
    
    var body: some View {
        ZStack {
            VStack {
                contant
                    .animation(.easeIn(duration: 0.2), value: true)
                    .environmentObject(manager)
                    .environment(\.managedObjectContext, manager.container.viewContext)
                Spacer()
                TButton(text: buttonText,
                        config: buttonConfig) {
                    hideKeyboard()
                    didApprove()
                }
            }
            .padding(.top, 68)
            .padding(.bottom, 72)
            .padding(.horizontal, 40)
            .ignoresSafeArea()
            .disabled(loading)
            
            if loading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .controlSize(.large)
                    .tint(.blue)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea()
            }
        }
    }
}

//#Preview {
//    OnboaredingBaseView(
//        buttonConfig: .constant(.defulat(state: .disabled,
//                                         dimantions: .full)),
//        buttonText: "אישור".localized(),
//        contant: SmsPinCodeView(phone: "0000000000", verificationID: "") { _ in
//            
//        } didApprove: { _, _ in
//            
//        }
//    ) {
//        
//    }
//}
