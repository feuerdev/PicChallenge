//
//  StagingView.swift
//  Piccy
//
//  Created by Jannik Feuerhahn on 03.05.21.
//

import SwiftUI

struct StagingView: View {
    
    private let columns: [GridItem] =
        Array(repeating: .init(.flexible()), count: 3)
    
    @EnvironmentObject var app:AppInfo
    
    @State private var showPicker: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack {
                        VStack(alignment:.leading) {
                            Text("Challenge")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("\(app.photos.count) Photos")
                                .font(.caption)
                        }
                        
                        Spacer()
                        Button(action: {                            
                            showPicker = true
                        }) {
                            Image(systemName: "plus")
                        }
                        .font(.title)
                    }
                    
                    if app.photos.count > 0 {
                        GeometryReader { proxy in
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 3) {
                                    ForEach(Array(app.photos), id: \.hash) { photo in
                                        Image(uiImage: photo)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: proxy.size.width/CGFloat(columns.count), height: proxy.size.width/CGFloat(columns.count), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .clipped()
                                            .transition(.opacity)
                                    }
                                }
                                
                                .animation(.easeInOut(duration: 1))
                            }
                        }
                    } else {
                        Spacer()
                        Text(app.debugText)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                        Spacer()
                    }
                }
                .padding([.horizontal, .top], 10)
                
                if app.photos.count > 0 {
                    VStack {
                        
                        Spacer()
                        
                        Button("Start") {
                            withAnimation() {
                                app.navigate(to: .challenge(competitors: Array(app.photos)))
                            }
                        }
                        .font(.title2)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(width: geo.size.width*0.7, height: 60)
                        .background(Constants.accentColor)
                        .cornerRadius(Constants.cornerRadius)
                        .shadow(radius:10)
                        .padding(.bottom)
                        
                    }
                }
            }.sheet(isPresented: $showPicker, onDismiss: {
                showPicker = false
            }, content: {
                ImagePicker(isPresented: $showPicker, vm:app)
            })
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            app.loadSharedPhotos()
        }
    }
}

struct StagingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StagingView()
        }
    }
}
