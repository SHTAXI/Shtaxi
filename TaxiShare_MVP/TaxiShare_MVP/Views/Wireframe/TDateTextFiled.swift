//
//  TDateTextFiled.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI
import Combine

struct TDateTextFiled: View {
    enum DateFiled: Int, Hashable {
        case day, month, year
    }
    
    @State private var day: String = ""
    @State private var month: String = ""
    @State private var year: String = ""
    let didType: (String, String, String) -> ()
    
    @FocusState private var focusedField: DateFiled?
    
    var body: some View {
        HStack {
            TDateComponnet(label: "יום",
                           text: $day,
                           limit: 2) { text in
                var backup = text
                while backup.first == "0" { backup.removeFirst() }
                if backup.count == 2 {
                    focusedField = DateFiled(rawValue: 1)!
                }
                didType(day, month, year)
            }
                           .frame(maxWidth: 79)
                           .focused($focusedField, equals: DateFiled(rawValue: 0)!)
            separetor()
            TDateComponnet(label: "חודש",
                           text: $month,
                           limit: 2) { text in
                var backup = text
                while backup.first == "0" { backup.removeFirst() }
                if backup.count == 2 {
                    focusedField = DateFiled(rawValue: 2)!
                }
                else if backup.isEmpty {
                    focusedField = DateFiled(rawValue: 0)!
                }
                didType(day, month, year)
                
            }
                           .frame(maxWidth: 79)
                           .focused($focusedField, equals: DateFiled(rawValue: 1)!)
            separetor()
            TDateComponnet(label: "שנה",
                           text: $year,
                           limit: 4) { text in
                var backup = text
                while backup.first == "0" { backup.removeFirst() }
                if backup.isEmpty {
                    focusedField = DateFiled(rawValue: 1)!
                }
                didType(day, month, year)
                
            }
                           .frame(maxWidth: 167)
                           .focused($focusedField, equals: DateFiled(rawValue: 2)!)
        }
        .frame(height: 52)
        .padding(.bottom, 19)
        .onAppear {
            self.focusedField = .day
        }
    }
    
    @ViewBuilder private func separetor() -> some View {
        Text("/")
            .font(Custom.shared.font.textMedium)
            .foregroundStyle(Custom.shared.color.inputFiled)
    }
}

struct TDateComponnet: View {
    let label: String
    @Binding var text: String
    let limit: Int
    let didType: (String) -> ()
    
    var body: some View {
        VStack {
            TTextFiledView(label: label,
                           text: $text,
                           textColor: Custom.shared.color.inputFiled,
                           keyboardType: .numberPad) { _ in }
                .onReceive(Just(text)) { _ in
                    while text.first == "0" { text.remove(at: text.startIndex ) }
                    if !text.isEmpty && text.count < limit {
                        text = String(repeating: "0", count: limit - text.count) + text
                    }
                    text.limitText(limit)
                    didType(text)
                }
            ZStack {
                Color.black
            }
            .frame(height: 1)
        }
    }
}

#Preview {
    TDateTextFiled { day, month, year in
        
    }
}
