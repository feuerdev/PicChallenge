//
//  ChallengeView.swift
//  PicChallenge
//
//  Created by Jannik Feuerhahn on 11.05.21.
//

import SwiftUI

struct ChallengeView: View {
    
    let vertical = true
    
    var body: some View {
        GeometryReader { proxy in
            if vertical {
                VStack(spacing: 0) {
                    Image("cat")
                        .resizable(resizingMode:.stretch)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height/2)
                        .clipped()
                        
                    Image("cat")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height/2)
                        .clipped()
                }
            } else {
                HStack(spacing: 0) {
                    Image("cat")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width/2, height: proxy.size.height)
                        .clipped()
                        
                    Image("cat")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width/2, height: proxy.size.height)
                        .clipped()
                }
            }
            
        }
    }
}

struct ChallengeView_Previews:PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
