//
//  router.swift
//  PicChallenge
//
//  Created by Jannik Feuerhahn on 09.05.21.
//

import Foundation

class Router: ObservableObject {
    @Published private(set) var currentPage: NavigationPage = .staging
    
    // MARK: - Intents
    func navigate(to page:NavigationPage) {
        self.currentPage = page
    }
    
}
