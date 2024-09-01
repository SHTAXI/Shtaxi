//
//  OnboardingBirthdateView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI

class DateHolder: ObservableObject {
    static var shared = DateHolder()
    @Published var date: String = ""
    private init(){}
}

struct OnboardingBirthdateView: OnboardingProgress {
    @State var date: String {
        didSet {
            
        }
    }
    internal let onAppear: (() -> ())? = nil
    internal let complition: ((_ enable: Bool) -> ())?
    internal let didSkip: (() -> ())? = nil
    internal let vm: OnboardringViewModel? = OnboardringViewModel()
    internal let holder = DateHolder.shared
    
    @State private var error: Bool = false
    @State private var errorValue: String? = nil {
        didSet {
            if let errorValue {
                error = errorValue.isEmpty
            }
            else {
                error = false
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                RightText(text: "מה תאריך הלידה שלך?",
                          font: Custom.shared.font.title)
            }
            .padding(.bottom, 20)
            
            VStack {
                let componnets = date.components(separatedBy: "/")
                let (day, month, year) = componnets.count == 3 ? (componnets[0], componnets[1], componnets[2]) : ("", "", "")
                TDateTextFiled(day: day,
                               month: month,
                               year: year,
                               error: $error) { day, month, year in
                    let newDate = "\(day)/\(month)/\(year)"
                    if newDate != date { errorValue = nil }
                    date = newDate
                    holder.date = newDate
                    let dayValid = day.count == 2
                    let monthValid = month.count == 2
                    let yearValid = year.count == 4
                    
                    complition?(dayValid && monthValid && yearValid)
                }
                
                if let errorValue {
                    Text(errorValue)
                        .foregroundStyle(Custom.shared.color.error)
                        .font(Custom.shared.font.textSmall)
                        .padding(.bottom, -5)
                }
            }
            .padding(.bottom, 20)
            
            Text("כדי להתאים את הנסיעות הנכונות עבורך אנחנו צריכים להבין מה תאריך הלידה שלך. בפרופיל נציג את הגיל שלך.")
                .multilineTextAlignment(.center)
                .font(Custom.shared.font.textSmall)
                .foregroundStyle(Custom.shared.color.infoText)
        }
    }
    
    func preformAction(manager: PersistenceController, profile: Profile, complete: @escaping (_ valid: Bool) -> ()) {
        errorValue = nil
        vm?.upload(id: profile.userID,
                   birthdate: holder.date) { _ in
            manager.set(profile: profile,
                        date: holder.date)
            complete(true)
        } error: { error in
            print(error)
        }
    }
}

//#Preview {
//    OnboardingBirthdateView { _ in
//
//    }
//}
