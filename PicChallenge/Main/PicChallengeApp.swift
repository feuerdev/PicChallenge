//
//  PicChallengeApp.swift
//  PicChallenge
//
//  Created by Jannik Feuerhahn on 03.05.21.
//

import SwiftUI

@main
struct PicChallengeApp: App {
    
    var app = AppInfo()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(app)
        }
    }
}
