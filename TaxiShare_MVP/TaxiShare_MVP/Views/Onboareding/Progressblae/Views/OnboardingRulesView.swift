//
//  OnboardingRulesView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI

struct OnboardingRulesView: ViewWithVM {
    let didAppear: () -> ()
   
    var body: some View {
        VStack {
            HStack {
                Spacer()
                RightText(text: "ברוך הבא לשטקסי!",
                          font: Custom.shared.font.title)
            }
            HStack {
                Spacer()
                RightText(text: "כמה נקודות חשובות על האפליקציה שלנו",
                          font: Custom.shared.font.textMedium)
            }
            .padding(.bottom, 44)
            
            VStack {
                ruleView(title: "עקרון ראשון",
                         text: "Lorem ipsum dolor sit amet consectetur. Lorem turpis nullam.")
                .padding(.bottom, 20)
                
                ruleView(title: "עקרון שני",
                         text: "Lorem ipsum dolor sit amet consectetur. Lorem turpis nullam.")
                .padding(.bottom, 20)
                
                ruleView(title: "עקרון שלישי",
                         text: "Lorem ipsum dolor sit amet consectetur. Lorem turpis nullam.")
            }
        }
        .onAppear {
            didAppear()
        }
    }
    
    @ViewBuilder private func ruleView(title: String, text: String) -> some View {
        VStack {
            HStack {
                Spacer()
                Image("bullet")
                    .resizable()
                    .frame(height: 28)
                    .frame(width: 28)
            }
            
            HStack {
                Spacer()
                RightText(text: title,
                          font: Custom.shared.font.textMediumBold)
                .foregroundStyle(Custom.shared.color.darkText)
            }
            
            HStack {
                Spacer()
                RightText(text: text,
                          font: Custom.shared.font.textMedium)
                .foregroundStyle(Custom.shared.color.infoText)
            }
        }
    }
    
    func preformAction() {}
}

#Preview {
    OnboardingRulesView {
        
    }
}
