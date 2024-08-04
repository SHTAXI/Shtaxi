//
//  OnboardingLoginView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI
import AuthenticationServices

public enum LoginType {
    case apple, google, facebook, phone(number: String)
}

struct OnboardingLoginView: ViewWithVM {
    let didSignup: (_ loginType: LoginType, _ name: String?, _ email: String?) -> ()
    let didFillPhone: (_ number: String) -> ()
    private let vm: OnboardringViewModel = OnboardringViewModel()
    
    var body: some View {
        VStack {
            TLogo(size: 64)
                .padding(.bottom, 40)
            HStack {
                Spacer()
                RightText(text: "יצירת חשבון",
                          font: Custom.shared.font.title)
            }
            .padding(.bottom, 28)
            
            VStack {
                SignInWithAppleButton(.signUp) { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                    switch result {
                    case .success(let authorization):
                        if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                            didSignup(.apple, userCredential.fullName?.givenName, userCredential.email)
                        }
                    case .failure:
                        break
                    }
                }
            }
        }
    }
    
    func preformAction() { 
        vm.upload(phone: "")
    }
}

#Preview {
    OnboardingLoginView() { _, _, _ in
        
    } didFillPhone: { _ in
        
    }
}
