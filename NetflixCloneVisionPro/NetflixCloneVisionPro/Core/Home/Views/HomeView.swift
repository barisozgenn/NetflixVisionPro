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
    @State private var contents: [ContentModel] = []
    @State private var selectedMenu: EMenu = .home
    @State private var searchText: String = ""
    @State private var selectedContent: SelectedContent? = nil
    
    private var api: ContentAPI
    
    init() {
        api = ContentAPI()
    }
    var body: some View {
        ZStack{
            mainView
        }
    }
    private var mainView: some View {
        ZStack(alignment: .top){
            if !contents.isEmpty {
                ContentsView(contents: $contents, selectedContent: $selectedContent)
            }
            HStack(alignment: .top){
                MenuView(selectedMenu: $selectedMenu)
                TrailingMenuView(searchText: $searchText)
            }
        }
        .onAppear{
            contents = api.contents
        }
        
        .scaleEffect(selectedContent != nil ? 0.29 : 1)
        .offset(x: selectedContent != nil ? -270 : 0,
                y: selectedContent != nil ? -270 : 0)
        .rotation3DEffect(Rotation3D(angle: .degrees(selectedContent != nil ? 58 : 0), axis: .y))
    }
}

#Preview {
    HomeView()
}
