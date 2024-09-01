//
//  Custom.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

struct Custom {
    private let custom: CustomProvider = CustomProvider()
    static var shared: CustomProvider = Custom().custom
}

struct CustomProvider {
    internal init(){}
    lazy var color: ColorItem = ColorItem()
    lazy var font: FontItem = FontItem()
}

internal struct ColorItem {
    let tBlue: Color = Color(hex: "#0C8CE9")
    let tGray: Color = Color(hex: "#ACACAC")
    let lightText: Color = Color(hex: "#FAFAFA")
    let darkText: Color = Color(hex: "#131313")
    let infoText: Color = Color(hex: "#7B7B7B")
    let progressStart: Color = Color(hex: "#6CC1FF")
    let progressEnd: Color = Color(hex: "#0094FF")
    let inputFiled: Color = Color(hex: "#727272")
    let white: Color = .white
    let black: Color = .black
    let gray: Color = .gray
    let red: Color = .red
    let clear: Color = .clear
}

internal struct FontItem {
    let title: Font = .custom("NotoSansHebrew", size: 32).bold()
    let textHuge: Font = .custom("NotoSansHebrew", size: 34)
    let textHugeBold: Font = .custom("NotoSansHebrew", size: 34).bold()
    let textBig: Font = .custom("NotoSansHebrew", size: 20)
    let textBigBold: Font = .custom("NotoSansHebrew", size: 20).bold()
    let button: Font = .custom("NotoSansHebrew-SemiBold", size: 12)
    let textMedium: Font = .custom("NotoSansHebrew", size: 16)
    let textMediumBold: Font = .custom("NotoSansHebrew", size: 16).bold()
    let textSmall: Font = .custom("NotoSansHebrew", size: 12)
    let none: Font = .custom("", size: 0)
}
