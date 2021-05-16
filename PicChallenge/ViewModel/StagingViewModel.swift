//
//  StagingViewModel.swift
//  PicChallenge
//
//  Created by Jannik Feuerhahn on 13.05.21.
//

import SwiftUI

class StagingViewModel: ObservableObject, Pickable {
    
    @Published private(set) var photos: Set<UIImage> = []
    
    //MARK: - Intents
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
}
