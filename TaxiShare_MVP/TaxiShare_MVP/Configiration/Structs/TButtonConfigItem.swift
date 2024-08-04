//
//  TButtonConfigItem.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import Foundation
import SwiftUI

enum TButtonState: Hashable {
    case enabled, disabled, selectebale(selected: Bool), none
    
    func isDisabled() -> Bool {
        switch self {
        case .enabled:
            return false
        case .disabled:
            return true
        case .selectebale:
            return false
        case .none:
            return false
        }
    }
    
    func getForgroundColor() -> Color {
        switch self {
        case .enabled:
            return Custom.shared.color.lightText
        case .disabled:
            return Custom.shared.color.darkText
        case .selectebale(let selected):
            return selected ? Custom.shared.color.darkText : Custom.shared.color.inputFiled
        case .none:
            return Custom.shared.color.none
        }
    }
    
    func getBackroundColor() -> Color {
        switch self {
        case .enabled:
            return Custom.shared.color.tBlue
        case .disabled:
            return Custom.shared.color.tGray
        case .selectebale(let selected):
            return selected ? Custom.shared.color.tBlue : .white
        case .none:
            return Custom.shared.color.none
        }
    }
}

enum TButtonDimantions {
    case none, full, hagging
}

struct TButtonConfigItem: Equatable {
    let state: TButtonState
    let font: Font
    var cornerRadius: CGFloat = 0
    let dimantions: TButtonDimantions
}
