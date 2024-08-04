//
//  OnboardingProgressbaleManegerView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

enum OnboardingProgressbale: Int, Codable {
    case name, birthdate, gender, rules
}

struct OnboardingProgressbaleManegerView<Content: ViewWithVM>: ViewWithVM {
    @Binding private var value: Int
    @State private var texts: [String]
    @State private var total: Int
    private let screens: [OnboardingProgressbale]
    var content: Content?
    
    init(value: Binding<Int>, screens: [OnboardingProgressbale], content: Content) {
        self.screens = screens
        _value = value
        self.content = content
        self.total = screens.count
        
        var texts: [String] = []
        
        for i in 0..<screens.count - 1 {
            if i == 0 {
                texts.append("כמה פרטים וסיימנו..")
            }
            else if i == screens.count - 2 {
                texts.append("כבר מסיימים..")
            }
            else {
                texts.append("עוד רגע שם..")
            }
        }
        
        texts.append("אחרון להיום..")
        
        self.texts = texts
    }
    
    var body: some View {
        if let content {
            OnboardingProgressbaleView(value: $value,
                                       texts: $texts,
                                       total: total,
                                       contant: content)
        }
    }
    
    func preformAction() {
        content?.preformAction()
    }
}

//#Preview {
//    OnboardingProgressbaleManegerView(value: .constant(0),
//                                      screens: [.rules, .birthdate, .gender, .rules]) { enable in
//        
//    }
//}
