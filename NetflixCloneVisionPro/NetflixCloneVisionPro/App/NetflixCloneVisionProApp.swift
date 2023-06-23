//
//  NetflixCloneVisionProApp.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 23.06.2023.
//

import SwiftUI

@main
struct NetflixCloneVisionProApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
