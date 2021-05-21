//
//  PiccyApp.swift
//  Piccy
//
//  Created by Jannik Feuerhahn on 03.05.21.
//

import SwiftUI

@main
struct PiccyApp: App {
    
    var app = AppInfo()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(app)
        }
    }
}
