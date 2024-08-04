//
//  TLogo.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 03/08/2024.
//

import SwiftUI

struct TLogo: View {
    let size: CGFloat
    var body: some View {
       Image("logo")
            .resizable()
            .clipShape(Circle())
            .frame(width: size)
            .frame(height: size)
    }
}

#Preview {
    TLogo(size: 64)
}
