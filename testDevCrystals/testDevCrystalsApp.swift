//
//  testDevCrystalsApp.swift
//  testDevCrystals
//
//  Created by Aaron Ploetz on 5/11/24.
//

import SwiftUI

@main
struct testDevCrystalsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
        }
    }
}
