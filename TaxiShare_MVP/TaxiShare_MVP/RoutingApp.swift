//
//  TaxiShare_MVPApp.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 27/06/2024.
//

import SwiftUI

@main
struct TaxiShare_MVPApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RouterView {
                RootView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
