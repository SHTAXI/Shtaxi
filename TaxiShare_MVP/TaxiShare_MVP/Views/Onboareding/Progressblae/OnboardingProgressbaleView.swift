//
//  OnboardingProgressbaleView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

struct OnboardingProgressbaleView<Contant: View>: View {
    @Binding var value: Int
    @Binding var texts: [String]
    let total: Int
    let contant: Contant
    
    var body: some View {
        VStack() {
            TProgressBar(value: $value,
                         total: total,
                         text: $texts[value])
            .padding(.bottom, 50)
            contant
            Spacer()
        }
    }
}

#Preview {
    OnboardingProgressbaleView(value: .constant(0),
                               texts: .constant([""]) ,
                               total: 4,
                               contant: OnboardingNameView() { _ in
        
    })
}
