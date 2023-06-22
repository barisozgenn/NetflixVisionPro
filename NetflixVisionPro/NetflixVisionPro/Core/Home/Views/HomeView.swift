//
//  HomeView.swift
//  NetflixVisionPro
//
//  Created by Baris OZGEN on 22.06.2023.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    @State var selectedMenu: EMenu = .home

    var body: some View {
        MenuView(selectedMenu: $selectedMenu)
    }
}

#Preview {
    HomeView()
}
