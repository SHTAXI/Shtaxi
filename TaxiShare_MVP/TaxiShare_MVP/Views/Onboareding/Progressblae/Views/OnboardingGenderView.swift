//
//  OnboardingGenderView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI

struct OnboardingGenderView: ViewWithVM {
    @State private var buttons: [TButtonParams] = {
        return [
            .init(title: "זכר",
                  config: .defulat(state: .selectebale(selected: false), dimantions: .full)),
            .init(title: "נקבה",
                  config: .defulat(state: .selectebale(selected: false), dimantions: .full)),
            .init(title: "אחר",
                  config: .defulat(state: .selectebale(selected: false), dimantions: .full))
        ]
    }()
    
    @State private var gender: String = ""
    
    let didSelect: (String) -> ()
    
    let didSkip: () -> ()
    
    private let vm = OnboardringViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                RightText(text: "מה המגדר שלך?",
                          font: Custom.shared.font.title)
            }
            .padding(.bottom, 20)
            
            VStack(spacing: 16) {
                ForEach(buttons, id: \.self) { button in
                    TSelectableButton(text: button.title,
                                      config: $buttons[buttons.firstIndex(of: button)!].config) {
                        for i in 0..<buttons.count {
                            buttons[i].config = .defulat(state: .selectebale(selected: false), dimantions: .full)
                        }
                        
                        buttons[buttons.firstIndex(of: button)!].config = .defulat(state: .selectebale(selected: true), dimantions: .full)
                        
                        gender = button.title
                        
                        didSelect(button.title)
                    }
                }
            }
            .padding(.bottom, 24)
            
            Button(action: {
                gender = ""
                didSkip()
            }, label: {
                Text("לא רוצה להגדיר כרגע")
                    .foregroundStyle(Custom.shared.color.tBlue)
                    .font(Custom.shared.font.textMedium)
            })
            .padding(.bottom, 20)
            
            Text("Lorem ipsum dolor sit amet consectetur. Pulvinar sed in dui auctor imperdiet posuere bibendum. Diam sit sed semper.")
                .multilineTextAlignment(.center)
                .font(Custom.shared.font.textSmall)
                .foregroundStyle(Custom.shared.color.infoText)
        }
    }
    
    func preformAction() {
        vm.upload(gender: gender)
    }
}

#Preview {
    OnboardingGenderView { _ in
        
    } didSkip: {
        
    }
}
