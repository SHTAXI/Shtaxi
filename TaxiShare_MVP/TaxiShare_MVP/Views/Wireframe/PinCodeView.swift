//
//  PinCideView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI
import Combine

struct PinCodeView: View {
    enum PinFiled: Int, Hashable {
        case one, two, three, four, five, six
    }
    
    let number: Int
    let didDone: ([String]) -> ()
    
    @State private var pinCodeList: [String]
    @FocusState private var focusedField: PinFiled?
    
    init(number: Int, didDone: @escaping ([String]) -> Void) {
        self.number = number
        self.didDone = didDone
        self.pinCodeList = [String](repeating: "", count: number)
    }
    
    var body: some View {
        HStack(spacing: 14.8) {
            ForEach(0..<number, id: \.self) { current in
                PinCodeItemView { value in
                    guard value else { return }
                    focusedField = PinFiled(rawValue: current)!
                } didType: { text in
                    if !pinCodeList[current].isEmpty && text.isEmpty {
                        if focusedField != .one {
                            focusedField = PinFiled(rawValue: current - 1)!
                        }
                    }
                    pinCodeList[current] = text
                    didDone(pinCodeList)
                    
                    if focusedField != .six {
                        guard !text.isEmpty else { return }
                        focusedField = PinFiled(rawValue: current + 1)!
                    }
                }
                .focused($focusedField, equals: PinFiled(rawValue: current)!)
            }
        }
        .onAppear {
            self.focusedField = .one
        }
    }
}

struct PinCodeItemView: View {
    @State var text: String = ""
    let isFocused: (Bool) -> ()
    let didType: (String) -> ()
    
    var body: some View{
        VStack {
            TTextFiledView(label: "",
                           text: $text, 
                           textColor: .black,
                           keyboardType: .numberPad,
                           isFocused: { value in
                isFocused(value)
            })
            .padding(.top, 6)
            .onReceive(Just(text)) { _ in
                text.limitText(1)
                didType(text)
            }
            
            ZStack {
                Color.black
            }
            .frame(height: 1)
            .padding(.bottom, 18)
        }
    }
}

#Preview {
    PinCodeView(number: 6) { _ in
        
    }
}
