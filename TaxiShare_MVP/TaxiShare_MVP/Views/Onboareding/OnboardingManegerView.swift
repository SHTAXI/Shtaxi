//
//  OnboardingManegerView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

struct OnboardingManegerView: View {
    let type: OnboaredingType
    @State private var buttonConfig: TButtonConfig
    @State private var progreesSatge: Int
    @State private var phone: String = ""
    
    private var screenNumber = 0
    
    let didApprove: () -> ()
    let didLogin: (LoginType, String?, String?) -> ()
    
    init(type: OnboaredingType, didApprove: @escaping () -> (), didLogin: @escaping (LoginType, String?, String?) -> ()) {
        self.type = type
        self.didApprove = didApprove
        self.didLogin = didLogin
        self.buttonConfig = .defulat(state: .disabled,
                                     dimantions: .full)
        self.progreesSatge = 0
        
        switch type {
        case .pinCode, .login:
            self.screenNumber = 0
        case .progressbale(let screens):
            self.screenNumber = screens.count
        }
    }
    
    var body: some View {
        onboardingView(type: type)
    }
    
    private func setButtonConfig(isDone: Bool) {
        withAnimation {
            buttonConfig = .defulat(state: isDone ? .enabled : .disabled,
                                    dimantions: .full)
        }
    }
    
    @ViewBuilder private func notReadyView() -> some View {
        VStack {
            Text("No Ready")
                .frame(maxHeight: .infinity)
        }
    }
    
    @ViewBuilder private func onboardingView(type: OnboaredingType) -> some View {
        switch type {
        case .login:
            OnboaredingBaseView(buttonConfig: $buttonConfig,
                                buttonText: "אישור",
                                contant: OnboardingLoginView() { type, name, emil in
                didLogin(type, name, emil)
            } didFillPhone: { number in
                phone = number
                setButtonConfig(isDone: number.count == 10)
            }) {
                didLogin(.phone(number: phone), "", "")
            }
        case .pinCode(let phone):
            OnboaredingBaseView(buttonConfig: $buttonConfig,
                                buttonText: "אישור",
                                contant: SmsPinCodeView(phone: phone) { value in
                setButtonConfig(isDone: value)
            }) {
                didApprove()
            }
        case .progressbale(let screens):
            if progreesSatge < screens.count {
                switch screens[progreesSatge] {
                case .name:
                    OnboaredingBaseView(buttonConfig: $buttonConfig,
                                        buttonText: progreesSatge < screenNumber - 1 ? "אישור" : "שנצא לדרך?",
                                        contant: OnboardingProgressbaleManegerView<OnboardingNameView>(value: $progreesSatge,
                                                                                                       screens: screens,
                                                                                                       content: OnboardingNameView { enable in
                        setButtonConfig(isDone: enable)
                    })) {
                        approve()
                    }
                case .birthdate:
                    OnboaredingBaseView(buttonConfig: $buttonConfig,
                                        buttonText: progreesSatge < screenNumber - 1 ? "אישור" : "שנצא לדרך?",
                                        contant: OnboardingProgressbaleManegerView<OnboardingBirthdateView>(value: $progreesSatge,
                                                                                                       screens: screens,
                                                                                                       content: OnboardingBirthdateView { enable in
                        setButtonConfig(isDone: enable)
                    })) {
                        approve()
                    }
                case .gender:
                    OnboaredingBaseView(buttonConfig: $buttonConfig,
                                        buttonText: progreesSatge < screenNumber - 1 ? "אישור" : "שנצא לדרך?",
                                        contant: OnboardingProgressbaleManegerView<OnboardingGenderView>(value: $progreesSatge,
                                                                                                         screens: screens,
                                                                                                         content: OnboardingGenderView { enable in
                        setButtonConfig(isDone: !enable.isEmpty)
                    } didSkip: {
                        approve()
                    })) {
                        approve()
                    }
                case .rules:
                    OnboaredingBaseView(buttonConfig: $buttonConfig,
                                        buttonText: progreesSatge < screenNumber - 1 ? "אישור" : "שנצא לדרך?",
                                        contant: OnboardingProgressbaleManegerView<OnboardingRulesView>(value: $progreesSatge,
                                                                                                        screens: screens,
                                                                                                        content: OnboardingRulesView {
                        setButtonConfig(isDone: true)
                    })) {
                        approve()
                    }
                }
            }
        }
    }
    
    private func approve() {
        guard progreesSatge == screenNumber - 1 else {
            setButtonConfig(isDone: false)
            withAnimation {
                progreesSatge += 1
            }
            
            return
        }
        didApprove()
    }
}

#Preview {
    OnboardingManegerView(type: .pinCode(phone: "050-2217124")) {
        
    } didLogin: { _,  _, _ in
        
    }
}
