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
    let contentModel: ContentAPI
    @State var selectedMenu: EMenu = .home
    @State var searchText: String = ""
    @State var isContentReady = false
    
    init(contentModel: ContentAPI) {
        self.contentModel = contentModel
    }
    var body: some View {
        ZStack(alignment: .top){
            if isContentReady {
                ContentsView(contents: contentModel.contents)
            }
            HStack(alignment: .top){
                MenuView(selectedMenu: $selectedMenu)
                TrailingMenuView(searchText: $searchText)
            }
        }
        .onChange(of: contentModel.contents.isEmpty) { oldC, newC in
            if !oldC || !newC {
                isContentReady.toggle()
            }
        }
    }
}

#Preview {
    HomeView(contentModel: ContentAPI())
}
