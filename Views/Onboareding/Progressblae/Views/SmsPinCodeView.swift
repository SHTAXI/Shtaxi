//
//  SmsPinCodeView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

class SmsPinCodeHolder: ObservableObject {
    @Published var pinCode: String = ""
}

struct SmsPinCodeView: ActionableView {
    let phone: String
    @State var verificationID: String
    let onAppear: (SmsPinCodeView) -> ()
    let didDone: (Bool) -> ()
    let didApprove: (_ id: String, _ name: String, _ email: String) -> ()
    
    internal let vm: OnboardringViewModel? = OnboardringViewModel()
    @State private var holder = SmsPinCodeHolder()
    @State private var error: Bool = false
    @State private var errorValue: String? = nil {
        didSet {
            if let errorValue { error = !errorValue.isEmpty }
            else { error = false }
        }
    }
    
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
                    Text("טעות במספר?".localized())
                        .font(Custom.shared.font.button)
                })
                
                Spacer()
                RightText(text: phone,
                          font: Custom.shared.font.textMediumBold)
                
                RightText(text: "שלחנו קוד ל",
                          font: Custom.shared.font.textMedium)
            }
            
            VStack {
                TPinCodeView(error: $error) { pinArray in
                    let pinCode = pinArray.joined()
                    if pinCode != holder.pinCode { errorValue = nil }
                    holder.pinCode = pinCode
                    didDone(!pinArray.contains(""))
                }
                
                if let errorValue {
                    Text(errorValue)
                        .foregroundStyle(Custom.shared.color.error)
                        .font(Custom.shared.font.textSmall)
                        .padding(.bottom, -5)
                }
            }
            .padding(.bottom, 20)
            
            Text("Lorem ipsum dolor sit amet consectetur. Pulvinar sed in dui auctor imperdiet posuere bibendum. Diam sit sed semper.")
                .multilineTextAlignment(.center)
                .font(Custom.shared.font.textSmall)
                .foregroundStyle(Custom.shared.color.infoText)
                .padding(.bottom, 4)
            
            Button(action: {
                errorValue = nil
                vm?.phoneAuth(phone: phone) { id in
                    verificationID = id
                } error: { err in
                    errorValue = nil
                    guard let err else { return }
                    print(err)
                }
            }, label: {
                Text("שליחה חוזרת")
                    .font(Custom.shared.font.textMedium)
                    .foregroundStyle(Custom.shared.color.tBlue)
                    .frame(height: 26)
            })
        }
        .onAppear {
            onAppear(self)
        }
    }
    
    func preformAction(manager: PersistenceController, profile: Profile, complete: @escaping (_ valid: Bool) -> ()) {
        errorValue = nil
        vm?.verifayPinCode(verificationID: verificationID,
                           code: holder.pinCode) { id, name, email in
            vm?.upload(id: profile.userID,
                       phone: phone) { _ in
                
                manager.set(profile: profile,
                            phone: phone)
                manager.set(profile: profile,
                            name: name)
                manager.set(profile: profile,
                            email: email)
                
                didApprove(id, name, email)
                
                complete(true)
            } error:  { err in
                print(err)
                errorValue = err
                complete(false)
            }
        } error: { err in
            if let err { print(err) }
            errorValue = err
            complete(false)
        }
    }
}

//#Preview {
//    SmsPinCodeView(phone: "050-2217124",
//                   verificationID: "") {
//
//    } didDone: { _ in
//
//    } didApprove: { _, _ in
//
//    }
//}
