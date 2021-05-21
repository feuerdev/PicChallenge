//
//  MainView.swift
//  Piccy
//
//  Created by Jannik Feuerhahn on 11.05.21.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var app:AppInfo
    
    var body: some View {
        Group {
            switch app.currentPage {
            case .staging:
                TabView {
                    StagingView()
                        .tabItem {
                            Label("Challenge", systemImage: "arrow.down.forward.and.arrow.up.backward")
                        }
                    
                    StagingView()
                        .tabItem {
                            Label("Explore", systemImage: "aqi.low")
                        }
                }
                .accentColor(Constants.accentColor)
            case .challenge:
                ChallengeView()
            case .winner(winner: let winner):
                WinnerView(winner: winner)
            }
        }
    }
    
}
