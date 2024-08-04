//
//  String+EXT.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import Foundation

extension String {
    mutating func limitText(_ upper: Int) {
        if count > upper {
            self = String(prefix(upper))
        }
    }
}
