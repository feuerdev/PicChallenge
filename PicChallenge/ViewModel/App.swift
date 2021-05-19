//
//  App.swift
//  PicChallenge
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
        if let links = UserDefaults(suiteName: "group.picchallenge")?.stringArray(forKey: "incomingURLs") {
            //Photos have been shared to the app
         
            for link in links {
                guard
                    let url = URL(string: link),
                    let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data) else { continue }
                print("successfully loaded image from share")
                photos.insert(image)
            }
            
            //reset
            UserDefaults(suiteName: "group.picchallenge")?.setValue(nil, forKey: "incomingURLs")
        }
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
