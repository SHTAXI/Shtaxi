//
//  CryptoManager.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 31/08/2024.
//


import Foundation
import CryptoKit

struct CryptoManager {
    static var key: SymmetricKey {
        return SymmetricKey(size: .bits256)
    }
    
    static func encryptData(data: Data) throws -> Data {
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }
    
    static func decryptData(data: Data) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }
}
