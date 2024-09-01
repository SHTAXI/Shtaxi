//
//  OnboardingNameView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI
import Combine

class NameHolder: ObservableObject {
    static var shared = NameHolder()
    @Published var name: String = ""
    private init(){}
}

struct OnboardingNameView: OnboardingProgress {
    @State var text: String
    internal let onAppear: (() -> ())? = nil
    internal let complition: ((_ enable: Bool) -> ())?
    internal let didSkip: (() -> ())? = nil
    internal let vm = OnboardringViewModel()
    internal let holder = NameHolder.shared
    
    enum NameFiled: Int, Hashable {
        case name
    }
    
    @FocusState private var focusedField: NameFiled?
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                RightText(text: "מה השם שלך?",
                          font: Custom.shared.font.title)
            }
            .padding(.bottom, 20)
            
            TTextFiledView(label: "הכנסת שם פרטי",
                           text: $text,
                           textColor: .black,
                           keyboardType: .default,
                           textAlignment: .trailing) { _ in }
                .onReceive(Just(text)) { _ in
                    holder.name = text
                    complition?(!text.isEmpty)
                }
                .focused($focusedField, equals: .name)
                .padding(.trailing, 24)
            
            ZStack {
                Color.black
            }
            .frame(height: 1)
            .padding(.bottom, 20)
            
            Text("Lorem ipsum dolor sit amet consectetur. Pulvinar sed in dui auctor imperdiet posuere bibendum. Diam sit sed semper.")
                .multilineTextAlignment(.center)
                .font(Custom.shared.font.textSmall)
                .foregroundStyle(Custom.shared.color.infoText)
        }
        .onAppear {
            focusedField = .name
        }
    }
    
    func preformAction(manager: PersistenceController, profile: Profile, complete: @escaping (_ valid: Bool) -> ()) {
        vm.upload(id: profile.userID,
                  name: holder.name) { _ in
            manager.set(profile: profile,
                        name: holder.name)
            complete(true)
        } error: { error in
            print(error)
        }
    }
}

//#Preview {
//    OnboardingNameView { _ in
//        
//    }
//}
