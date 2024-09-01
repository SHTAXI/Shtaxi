//
//  GenericView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 04/08/2024.
//

import SwiftUI

protocol ActionableView: View {
    func preformAction(manager: PersistenceController, profile: Profile, complete: @escaping (_ valid: Bool) -> ())
}
