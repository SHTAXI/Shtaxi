//
//  TextFiledView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 30/06/2024.
//

import SwiftUI

struct TTextFiledView: View {
    let label: String
    @Binding var text: String
    let textColor: Color
    let keyboardType: UIKeyboardType
    let textAlignment: TextAlignment
    let isFocused: (Bool) -> ()
    
    var body: some View {
        TextField(label,
                  text: $text,
                  onEditingChanged: { value in
            isFocused(value)
        })
        .foregroundStyle(textColor)
        .multilineTextAlignment(textAlignment)
        .autocorrectionDisabled()
        .frame(maxWidth: .infinity)
        .keyboardType(keyboardType)
    }
}
