//
//  OnboardingBirthdateView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI

struct OnboardingBirthdateView: ViewWithVM {
    @State private var date: String = ""
    let didComplete: (Bool) -> ()
    
    private let vm = OnboardringViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                RightText(text: "מה תאריך הלידה שלך?",
                          font: Custom.shared.font.title)
            }
            .padding(.bottom, 20)
            HStack {
                TDateTextFiled { day, month, year in
                    date = "\(day)/\(month)/\(year)"
                    var dayBackup = day
                    while dayBackup.first == "0" { dayBackup.remove(at: dayBackup.startIndex ) }
                    let dayValid = dayBackup.count == 1 || dayBackup.count == 2
                    
                    var monthBackup = month
                    while monthBackup.first == "0" { monthBackup.remove(at: monthBackup.startIndex ) }
                    let monthValid = monthBackup.count == 1 || monthBackup.count == 2
                    
                    var yearBackup = year
                    while yearBackup.first == "0" { yearBackup.remove(at: yearBackup.startIndex ) }
                    let yearValid = yearBackup.count == 4
                    didComplete(dayValid && monthValid && yearValid)
                }
            }
            Text("כדי להתאים את הנסיעות הנכונות עבורך אנחנו צריכים להבין מה תאריך הלידה שלך. בפרופיל נציג את הגיל שלך.")
                .multilineTextAlignment(.center)
                .font(Custom.shared.font.textSmall)
                .foregroundStyle(Custom.shared.color.infoText)
        }
    }
    
    func preformAction() {
        vm.upload(birthdate: date)
    }
}

#Preview {
    OnboardingBirthdateView { _ in
        
    }
}
