//
//  MainView.swift
//  PicChallenge
//
//  Created by Jannik Feuerhahn on 11.05.21.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var router: Router = Router()
    
    var body: some View {
        switch router.currentPage {
        case .staging:
            TabView {
                StagingView(router: router)
                    .tabItem {
                        Label("Challenge", systemImage: "arrow.down.forward.and.arrow.up.backward")
                    }
                
                StagingView(router: router)
                    .tabItem {
                        Label("Explore", systemImage: "aqi.low")
                    }
            }
            .accentColor(Constants.accentColor)
        case .challenge:
            ChallengeView()
        }
    }
    
}
