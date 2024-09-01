//
//  OnboardingGenderView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI

class GenderHolder: ObservableObject {
    static var shared = GenderHolder()
    @Published var gender: Int?
    private init(){}
}

struct OnboardingGenderView: OnboardingProgress {
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
    
    @State internal var selectedIndex: Int?
    
    internal let onAppear: (() -> ())? = nil
    internal let complition: ((_ enable: Bool) -> ())?
    internal let didSkip: (() -> ())?
    internal let vm: OnboardringViewModel? = OnboardringViewModel()
    internal let holder = GenderHolder.shared
    
    init(selectedIndex: Int?, complition: ((_ enable : Bool) -> ())?, didSkip: (() -> ())?) {
        self.selectedIndex = selectedIndex
        self.complition = complition
        self.didSkip = didSkip
        
        for i in 0..<buttons.count {
            if i == selectedIndex {
                buttons[i].config = .defulat(state: .selectebale(selected: true),
                                             dimantions: .full)
                break
            }
        }
    }
    
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
                    if let index = buttons.firstIndex(of: button) {
                        TSelectableButton(text: button.title,
                                          config: $buttons[index].config) {
                            for i in 0..<buttons.count {
                                let selected = i == index
                                buttons[i].config = .defulat(state: .selectebale(selected: selected), 
                                                             dimantions: .full)
                                selectedIndex = index
                                holder.gender = index
                                complition?(!button.title.isEmpty)
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 24)
            
            Button(action: {
                selectedIndex = -1
                holder.gender = -1
                didSkip?()
            }, label: {
                Text("לא רוצה להגדיר כרגע".localized())
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
    
    func preformAction(manager: PersistenceController, profile: Profile, complete: @escaping (_ valid: Bool) -> ()) {
        vm?.upload(id: profile.userID,
                   gender: holder.gender) { _ in
            manager.set(profile: profile,
                        gender: holder.gender)
            complete(true)
        } error: { error in
            print(error)
        }
    }
}

//#Preview {
//    OnboardingGenderView { _ in
//        
//    } didSkip: {
//        
//    }
//}
