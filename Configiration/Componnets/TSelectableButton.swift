//
//  TSelectableButton.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI

struct TSelectableButton: View {
    let text: String
    @Binding var config: TButtonConfig
    let isSelected: () -> ()
    
    var body: some View {
        TButton(text: text, config: config) {
            isSelected()
        }
    }
}

#Preview {
    TSelectableButton(text: "sdfsdfsd",
                      config: .constant(.init(rawValue: .init(state: .selectebale(selected: false),
                                                              font: .title,
                                                              dimantions: .full))!)) {
        
    }
}
