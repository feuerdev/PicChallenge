//
//  NavigationPage.swift
//  Piccy
//
//  Created by Jannik Feuerhahn on 11.05.21.
//

import SwiftUI

enum NavigationPage {
    case staging(challenge:Int)
    case challenge(competitors:[UIImage])
    case winner(winner:UIImage)
}
