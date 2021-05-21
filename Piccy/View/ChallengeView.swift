//
//  ChallengeView.swift
//  Piccy
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
                    if let left = app.tournament?.nextOpenMatch()?.left?.winner {
                        Image(uiImage: left)
                            .aspectFill(width: proxy.size.width, height: proxy.size.height/2)
                            .onTapGesture { app.pickLeft() }
                    }
                    if let right = app.tournament?.nextOpenMatch()?.right?.winner {
                        Image(uiImage: right)
                            .aspectFill(width: proxy.size.width, height: proxy.size.height/2)
                            .onTapGesture { app.pickRight() }
                    }
                }
            } else {
                HStack(spacing: 0) {
                    if let left = app.tournament?.nextOpenMatch()?.left?.winner {
                        Image(uiImage: left)
                            .aspectFill(width: proxy.size.width/2, height: proxy.size.height)
                            .onTapGesture {
                                app.pickLeft()
                            }
                    }
                    if let right = app.tournament?.nextOpenMatch()?.right?.winner {
                        Image(uiImage: right)
                            .aspectFill(width: proxy.size.width/2, height: proxy.size.height)
                            .onTapGesture {
                                app.pickRight()
                            }
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
