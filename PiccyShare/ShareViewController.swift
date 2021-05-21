//
//  ShareViewController.swift
//  Piccy
//
//  Created by Jannik Feuerhahn on 12.02.21.
//

import Feuerlib
import UIKit
import Social
import CoreServices

class ShareViewController: FeuerShareViewController {

    private let groupName = "group.piccy"
    private let urlDefaultName = "incomingURLs"
    private let urlScheme = "challenge://"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let attachments = extensionItem.attachments else {
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
            return
        }
        
        let group = DispatchGroup()
        var urlStrings = [String]()
        for attachment in attachments {
            if attachment.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
                group.enter()
                attachment.loadItem(forTypeIdentifier: kUTTypeImage as String, options: nil) { (data, error) in
                    guard error == nil,
                          let url = data as? URL,
                          let imageData = try? Data(contentsOf: url) else {
                        group.leave()
                        return
                    }
                    self.saveImage(imageData, key: url.absoluteString)
                    urlStrings.append(url.absoluteString)
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            self.saveImageUrl(urlStrings)
            self.openMainApp()
        }
    }
    
    func saveImage(_ imageData:Data, key:String) {
        guard let groupDefaults = UserDefaults(suiteName: self.groupName) else {
            return
        }
        groupDefaults.set(imageData, forKey: key)
        groupDefaults.synchronize()
    }
    
    func saveImageUrl(_ urlStrings:[String]) {
        guard let groupDefaults = UserDefaults(suiteName: self.groupName) else {
            return
        }
        groupDefaults.set(urlStrings, forKey: urlDefaultName)
        groupDefaults.synchronize()
    }
    
    func openMainApp() {
        self.extensionContext?.completeRequest(returningItems: nil, completionHandler: { _ in
            guard let url = URL(string: self.urlScheme) else { return }
            _ = self.openURL(url)
        })
    }
}
