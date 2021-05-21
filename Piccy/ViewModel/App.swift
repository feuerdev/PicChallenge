//
//  App.swift
//  Piccy
//
//  Created by Jannik Feuerhahn on 18.05.21.
//

import Feuerlib
import SwiftUI

class AppInfo:ObservableObject, Pickable {
    
    //Staging
    @Published private(set) var currentPage: NavigationPage = .staging(challenge: 0)
    @Published private(set) var photos: Set<UIImage> = []
    
    //Challenge
    @Published private(set) var tournament:TournamentTree<UIImage>?
    
    @Published private(set) var debugText:String = ""
    
    //Winner
    @Published private(set) var winner:UIImage?
    
    private func checkFinished() {
        guard let tournament = tournament,
              let winner = tournament.finals.winner else {
            return
        }
        
        navigate(to: .winner(winner: winner))
        //TODO: navigate to winning screen
        
    }
    
    // MARK: - Intents Navigation
    func navigate(to page:NavigationPage) {
        switch page {
        case .challenge(let competitors):
            tournament = TournamentTree(competitors)
        case .staging(let challenge):
            break
//            TODO: self.stagingVm.selected = challenge
        case .winner(let winner):
            break
//            TODO: winnerVm.winner = winner
        }
        self.currentPage = page
    }
    
    //MARK: - Intents Staging
    func pickedPhoto(_ photo:UIImage) {
        self.photos.insert(photo)
        print("picked")
        self.objectWillChange.send()
    }
    
    func loadSharedPhotos() {
        guard let groupDefaults = UserDefaults(suiteName: "group.piccy") else {
            debugText = "No Suite"
            return
        }
        
        guard let incomingLinks = groupDefaults.stringArray(forKey: "incomingURLs") else {
            debugText = "No Shared Links"
            return
        }
        
        debugText = "Shared Links: \(incomingLinks.count) - \(incomingLinks.first)"
        //Photos have been shared to the app
        for link in incomingLinks {
//            guard let url = URL(string: link) else { debugText = "Couldnt create url"; continue }
            guard let data = groupDefaults.data(forKey: link) else { debugText = "Couldnt create data from '\(link)' "; continue }
            guard let image = UIImage(data: data) else { debugText = "Couldnt create image"; continue }
            print("successfully loaded image from share")
            debugText = "Shared link loaded!"
            photos.insert(image)
        }
        
        //reset
        groupDefaults.setValue(nil, forKey: "incomingURLs")
        groupDefaults.synchronize()
    }
    
    //MARK: - Intents Challenge
    func pickLeft() {
        guard let match = tournament?.nextOpenMatch() else { return }
        match.winner = match.left?.winner
        checkFinished()
        objectWillChange.send()
    }
    
    func pickRight() {
        guard let match = tournament?.nextOpenMatch() else { return }
        match.winner = match.right?.winner
        checkFinished()
        objectWillChange.send()
    }
    
    //MARK: - Intents Winner
    
}
