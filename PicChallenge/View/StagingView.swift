//
//  StagingView.swift
//  PicChallenge
//
//  Created by Jannik Feuerhahn on 03.05.21.
//

import SwiftUI

struct StagingView: View {
    
    private let columns: [GridItem] =
        Array(repeating: .init(.flexible()), count: 3)
    
    @StateObject var router:Router
    @StateObject var vm: StagingViewModel = StagingViewModel()
    
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
                            Text("\(vm.photos.count) Photos")
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
                    
                    if vm.photos.count > 0 {
                        GeometryReader { proxy in
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 3) {
                                    ForEach(Array(vm.photos), id: \.hash) { photo in
                                        Image(uiImage: photo)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: proxy.size.width/CGFloat(columns.count), height: proxy.size.width/CGFloat(columns.count), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .clipped()
                                            .transition(.opacity)
                                    }
                                }
                                //                                .transition(.opacity)
                                .animation(.easeInOut(duration: 1))
                            }
                        }
                    } else {
                        Spacer()
                        Text("Add photos by using the + button in the top right or share some photos to this app")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                        Spacer()
                    }
                }
                .padding([.horizontal, .top], 10)
                
                if vm.photos.count > 0 {
                    VStack {
                        
                        Spacer()
                        
                        Button("Start") {
                            withAnimation() {
                                router.navigate(to: .challenge)
                            }
                        }
                        .font(.title2)
                        .foregroundColor(.white)
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
                ImagePicker(isPresented: $showPicker, vm:vm)
            })
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            print("foreground")
            vm.loadSharedPhotos()
        }
    }
}

struct StagingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StagingView(router: Router())
        }
    }
}
