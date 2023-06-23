//
//  HomeView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 23.06.2023.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    @State var selectedMenu: EMenu = .home
    @State var searchText: String = ""
    var body: some View {
        ZStack(alignment: .top){
            ContentsView()
            HStack(alignment: .top){
                MenuView(selectedMenu: $selectedMenu)
                TrailingMenuView(searchText: $searchText)
            }
        }
    }
}

#Preview {
    HomeView()
}
