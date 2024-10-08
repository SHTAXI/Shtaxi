//
//  OnboardingLoginView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI
import AuthenticationServices
import GoogleSignInSwift

struct OnboardingLoginView: View {
    let didSignup: (_ id: String, _ name: String?, _ email: String?, _ birthday: String?, _ gender: String?) -> ()
    let didFillPhone: (_ number: String) -> ()
    private let auth = Authentication()
    private let main = DispatchQueue.main
    
    fileprivate func googleSignInButton() -> some View {
        let button = Button(action: {
            hideKeyboard()
            Task {
                auth.googleOauth { model in
                    guard let model else { return }
                    main.async {
                        didSignup(model.id, model.givenName, model.email, "", nil)
                    }
                }
            }
        }, label: {
            ZStack(alignment: .center) {
                Image("google")
                    .resizable()
                    .frame(width: 25,
                           height: 25)
                    .padding(.trailing, 195)
                
                Text("התחברות עם גוגל".localized())
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
        })
            .buttonStyle(LoginButtonStyle())
            .font(.title2.weight(.medium))
            .foregroundStyle(Custom.shared.color.black)
        
        return makeLoginButton(view: button)
    }
    
    fileprivate func facebookSignInButton() -> some View {
        let button = Button(action: {
            hideKeyboard()
            auth.facebookAuth { model in
                main.async {
                    didSignup(model.id, model.name, model.email, model.birthday, model.gender)
                }
            }
        }, label: {
            ZStack(alignment: .center) {
                Image("facebook")
                    .resizable()
                    .frame(width: 25,
                           height: 25)
                    .padding(.trailing, 235)
                
                Text("התחברות עם פייסבוק".localized())
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
        })
            .buttonStyle(LoginButtonStyle())
            .font(.title2.weight(.medium))
            .foregroundStyle(Custom.shared.color.black)
        
        return makeLoginButton(view: button)
    }
    
    fileprivate func appleSignInButton() -> some View {
        let button = SignInWithAppleButton(.signUp) { request in
            hideKeyboard()
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authorization):
                main.async {
                    if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                        guard let id = userCredential.user.encrypt() else { return }
                        didSignup(id, userCredential.fullName?.givenName, userCredential.email, "", nil)
                    }
                }
            case .failure:
                break
            }
        }
            .signInWithAppleButtonStyle(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 149)
                    .stroke(Custom.shared.color.darkText ,
                            lineWidth: 1)
            )
        
        return makeLoginButton(view: button)
    }
    
    var body: some View {
        VStack {
            TLogo(shape: Circle(),
                  size: 64)
            .padding(.bottom, 40)
            
            HStack {
                Spacer()
                RightText(text: "יצירת חשבון",
                          font: Custom.shared.font.title)
            }
            .padding(.bottom, 20)
            
            VStack(spacing: 28) {
                facebookSignInButton()
                
                appleSignInButton()
                
                googleSignInButton()
            }
            .padding(.bottom, 36)
            
            VStack {
                HStack {
                    Image("line")
                        .resizable()
                        .frame(height: 1)
                    Text("או".localized())
                        .frame(width: 52)
                        .font(Custom.shared.font.textMedium)
                        .foregroundStyle(Custom.shared.color.infoText)
                    Image("line")
                        .resizable()
                        .frame(height: 1)
                }
                .padding(.bottom, 20)
                
                LoginPhoneView { phone in
                    didFillPhone(phone)
                }
                .padding(.bottom, 20)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    @ViewBuilder private func makeLoginButton(view: some View) -> some View {
        view
            .clipShape(RoundedRectangle(cornerRadius: 149))
            .frame(height: 56)
    }
}

struct LoginButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background {
                configuration.isPressed ? Custom.shared.color.gray.opacity(0.8) :
                Color.clear
            }
            .overlay(
                RoundedRectangle(cornerRadius: 149)
                    .stroke(Custom.shared.color.darkText ,
                            lineWidth: 1)
            )
    }
}

#Preview {
    OnboardingLoginView() { _, _, _, _, _ in
        
    } didFillPhone: { _ in
        
    }
}
