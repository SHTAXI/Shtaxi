//
//  Onboarding.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 28/08/2024.
//

import SwiftUI

protocol OnboardingProgress: ActionableView {
    var onAppear: (() -> ())? { get }
    var complition: ((_ enable: Bool) -> ())? { get }
    var otherAction: ((_ content: any ActionableView) -> ())? { get }
}
