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
    
    @State private var eScene: EScene = .contentsHome
    
    private var api: ContentAPI
    
    init() {
        api = ContentAPI()
    }
    var body: some View {
        ZStack{
            mainView
            expandedView
            playerView
        }
        .onChange(of: selectedContent == nil) { oldV, newV in
            withAnimation(.smooth()){
                guard let selectedContent else {
                    eScene = .contentsHome
                    return
                }
                if selectedContent.flowType == .expanded {
                    eScene = .expandedContent
                }else if selectedContent.flowType == .play {
                    eScene = .mainPlayer
                }
            }
            
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
        .scaleEffect(eScene != .contentsHome ? 0.29 : 1)
        .offset(x: eScene != .contentsHome ? -392 : 0,
                y: eScene != .contentsHome ? -358 : 0)
        .opacity(eScene == .contentsHome ? 1 : eScene == .expandedContent ? 0.729 : 0)
        .saturation(eScene == .contentsHome ? 1 : 0)
        /*
         // Low performance dedected
         .rotation3DEffect(
            Rotation3D(
                angle: .degrees(eScene != .contentsHome ? 7 : 0),
                axis: .y)
        )*/
    }
    private var playerView: some View {
        ZStack(alignment: .top){
            if let selectedContent,
               selectedContent.flowType == .play {
                MainPlayerView(selectedContent: $selectedContent)
            }
        }
        .scaleEffect(eScene == .mainPlayer ? 1 : 0)
        .offset(x: eScene == .mainPlayer ? 0 : 229,
                y: eScene == .mainPlayer ? 0 : -292)
    }
    private var expandedView: some View {
        ZStack(alignment: .top){
            if let selectedContent,
               selectedContent.flowType == .expanded {
                ContentExpandedView(selectedContent: $selectedContent, contents: $contents)
            }
        }
        .scaleEffect(eScene == .expandedContent ? 1 : 0)
        .offset(x: eScene == .expandedContent ? 92 : 229)
        .opacity(eScene == .expandedContent ? 1 : 0)
    }
}

#Preview {
    HomeView()
}
