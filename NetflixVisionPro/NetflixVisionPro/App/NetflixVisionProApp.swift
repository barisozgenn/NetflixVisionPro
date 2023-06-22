//
//  NetflixVisionProApp.swift
//  NetflixVisionPro
//
//  Created by Baris OZGEN on 22.06.2023.
//

import SwiftUI

@main
struct NetflixVisionProApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
