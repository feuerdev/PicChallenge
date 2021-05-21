//
//  WinnerView.swift
//  Piccy
//
//  Created by Jannik Feuerhahn on 18.05.21.
//

import SwiftUI

struct WinnerView: View {
    @EnvironmentObject var app:AppInfo
    
    var winner:UIImage
    
    @State private var isSharePresented = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(uiImage: winner)
                    .aspectFill(width: proxy.size.width, height: proxy.size.height)
                VStack {
                    Spacer()
                    Button("Share") {
                        isSharePresented = true
                    }
                    .font(.title2)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(width: proxy.size.width*0.7, height: 60)
                    .background(Constants.accentColor)
                    .cornerRadius(Constants.cornerRadius)
                    .shadow(radius:10)
                    .padding(.bottom)
                }
            }.sheet(isPresented: $isSharePresented) {
                ShareView(items: [winner])
            }
        }
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(winner: UIImage(named: "cat")!)
    }
}
