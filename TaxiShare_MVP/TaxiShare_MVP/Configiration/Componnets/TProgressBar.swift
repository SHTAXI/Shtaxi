//
//  TProgressBar.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

struct TProgressBar: View {
    @Binding var value: Int
    let total: Int
    @Binding var text: String
    
    var body: some View {
        ProgressView(value: CGFloat(value + 1),
                     total: CGFloat(total),
                     label: {
            HStack {
                Image("check")
                    .resizable()
                    .frame(height: 24)
                    .frame(width: 24)
                Text("שלבים \(value + 1)/\(total)")
                    .font(Custom.shared.font.textMedium)
                Spacer()
                Text(text)
                    .font(Custom.shared.font.button)
            }
        })
        .progressViewStyle(BarProgressStyle(height: 12))
        .frame(height: 48)
    }
}

struct BarProgressStyle: ProgressViewStyle {
    var height: Double = 20.0
    var labelFontStyle: Font = .body

    func makeBody(configuration: Configuration) -> some View {

        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { geometry in

            VStack(alignment: .leading) {

                configuration.label
                    .font(labelFontStyle)

                RoundedRectangle(cornerRadius: 79)
                    .fill(Color(uiColor: .systemGray5))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 79)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Custom.shared.color.progressStart, Custom.shared.color.progressEnd]),
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .frame(width: geometry.size.width * progress)
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {
                                    
                                    currentValueLabel
                                        .font(.headline)
                                        .clipShape(RoundedRectangle(cornerRadius: 79))
                                }
                            }
                    }

            }

        }
    }
}

#Preview {
    TProgressBar(value: .constant(0),
                 total: 4,
                 text: .constant("עוד רגע שם.."))
}
