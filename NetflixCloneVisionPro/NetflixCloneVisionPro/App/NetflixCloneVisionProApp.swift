//
//  NetflixCloneVisionProApp.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 23.06.2023.
//

import SwiftUI
import SwiftData

@main
struct NetflixCloneVisionProApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                
        }
        .windowStyle(.volumetric)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            //ImmersiveView()
        }
        /*WindowGroup("Content Info", id: "content-expanded-window") {
            ContentExpandedView(contentModel: contentModel)
                .preferredColorScheme(.dark)
                .toolbarBackground(LinearGradient(
                    colors: [
                        Color(.black),
                        Color(.darkGray)
                    ],
                    startPoint: .top,
                    endPoint: .bottom))
                
        }
        .windowStyle(.automatic)
        
        WindowGroup("Main Player", id: "main-player-window") {
            MainPlayerView(viewModel: playerViewModel)
        }*/
    }
}
