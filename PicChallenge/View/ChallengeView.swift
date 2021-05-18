//
//  ChallengeView.swift
//  PicChallenge
//
//  Created by Jannik Feuerhahn on 11.05.21.
//

import SwiftUI

struct ChallengeView: View {
    @EnvironmentObject var app:AppInfo
    
    var body: some View {
        GeometryReader { proxy in
            if proxy.size.width < proxy.size.height {
                VStack(spacing: 0) {
                    Image(uiImage: app.tournament!.nextOpenMatch()!.left!.winner!)
                        .aspectFill(width: proxy.size.width, height: proxy.size.height/2)
                        .onTapGesture { app.pickLeft() }
                    Image(uiImage: app.tournament!.nextOpenMatch()!.right!.winner!)
                        .aspectFill(width: proxy.size.width, height: proxy.size.height/2)
                        .onTapGesture { app.pickRight() }
                }
            } else {
                HStack(spacing: 0) {
                    Image(uiImage: app.tournament!.nextOpenMatch()!.left!.winner!)
                        .aspectFill(width: proxy.size.width/2, height: proxy.size.height)
                        .onTapGesture {
                            app.pickLeft()
                        }
                    Image(uiImage: app.tournament!.nextOpenMatch()!.right!.winner!)
                        .aspectFill(width: proxy.size.width/2, height: proxy.size.height)
                        .onTapGesture {
                            app.pickRight()
                        }
                }
            }
        }
    }
}

extension Image {
    func aspectFill(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipped()
    }
}

struct ChallengeView_Previews:PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
