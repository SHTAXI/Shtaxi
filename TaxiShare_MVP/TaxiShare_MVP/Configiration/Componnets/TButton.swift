//
//  TButton.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

struct TButton: View {
    let text: String
    let config: TButtonConfig
    let didTap: () -> ()
    
    var body: some View {
        Button(action: {
            didTap()
        }, label: {
            let text = Text(text)
            
            switch config {
            case .none:
                text
            case .defulat(_, let dimantions):
                switch dimantions {
                case .none, .hagging:
                    text
                case .full:
                    text
                        .frame(maxWidth: .infinity)
                }
            }
            
        })
        .buttonStyle(TButtonStyle(config: config))
        .disabled(config.rawValue.state.isDisabled())
    }
}

struct TButtonStyle: ButtonStyle {
    let config: TButtonConfig
    func makeBody(configuration: Configuration) -> some View {
        let label = configuration.label
            .padding(.top, 17)
            .padding(.bottom, 17)
            .multilineTextAlignment(.center)
            .foregroundStyle(config.rawValue.state.getForgroundColor())
            .background {
                config.rawValue.state.getBackroundColor()
            }
            .clipShape(RoundedRectangle(cornerRadius: config.rawValue.cornerRadius))
        
        switch config {
        case .none:
            label
        case .defulat(let state, _):
            switch state {
            case .selectebale:
                label
                    .overlay(
                        RoundedRectangle(cornerRadius: config.rawValue.cornerRadius)
                            .stroke(Custom.shared.color.darkText, lineWidth: 1)
                    )
            default:
                label
                   
            }
        }
    }
}

#Preview {
    VStack {
        TButton(text: "אישור",
                config: .defulat(state: .selectebale(selected: true),
                                 dimantions: .full)) {
            
        }
        
        TButton(text: "אישור",
                config: .defulat(state: .disabled,
                                 dimantions: .full)) {
            
        }
    }
}
