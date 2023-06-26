//
//  ContentsView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 23.06.2023.
//

import SwiftUI

struct ContentsView: View {
    @Binding var contents: [ContentModel]
    @Binding var selectedContent: SelectedContent?
    @Binding var selectionListId: Int
    @Binding var selectedMenu: EMenu
    
    @State private var scale = 0.0
    @State private var offsetY = 329.0
    @State private var offsetX = 329.0
    private let contentTitles: [String] = ["Trending Now","Top Picks For You", "Only on Netflix","Watch In One Weekend"]
    
    var body: some View {
        ZStack{
            if selectedMenu != .browseByLanguages {
                headerView
            }
            if selectedMenu == .movies {
                movieContents
            }else if selectedMenu == .browseByLanguages {
                browseByContents
            }else {
                homeContents
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(content: {
            RoundedRectangle(cornerSize: CGSize(width: 14, height: 14))
                .fill(.black.opacity(0.29))
        })
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 14, height: 14)))
        .padding(.leading, 258)
        .padding(.top, 72)
        .scaleEffect(y: scale)
        .offset(x: offsetX, y: offsetY)
        .onAppear{
            withAnimation(.smooth.delay(3.29)){
                offsetY = 0.0
                offsetX = 0.0
                scale = 1
            }
        }
    }
    
    private var linearGradient: some View {
        LinearGradient(colors: [.red, .red.opacity(0.5), .red.opacity(0)], startPoint: .top, endPoint: .bottom)
            .frame(height: 70)
            .padding(.top, 0)
            .padding(.bottom, -50)
    }
    private var headerView: some View {
        VStack(spacing: 0){
            ContentHeaderVideoPlayer(headerContent: contents[0], selectedContent: $selectedContent, selectedMenu: $selectedMenu)
                .saturation(selectionListId == -1 ? 1 : 0.29)
                .opacity(selectionListId == -1 ? 1 : 0.729)
            linearGradient
                .saturation(selectionListId == -1 ? 1 : 0.29)
            Spacer()
        }
    }
    private var homeContents: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading){
                ForEach(Array(contentTitles.enumerated()), id: \.offset){ index, title in
                    
                    let contentIteration = index * 4
                    let titleContents: [ContentModel] = Array(contents[contentIteration..<contentIteration+4])
                    
                    ListTitleView(title: title, animationDelay: .constant(3.729 + Double(index) * 0.29))
                        .padding(.top, index == 0 ? 14.729 : 2.297)
                        .offset(z: 1)
                        .saturation(selectionListId == -1 ? 1 : 0.29)
                    
                    ContentListView(
                        selectedContent: $selectedContent,
                        selectionListId: $selectionListId,
                        listId: index,
                        animationDelay: 5.297 + Double(index) * 0.729,
                        contents: titleContents
                    )
                    .padding(.vertical, -75)
                }
            }
        }
        .padding(.top, 329)
    }
    private var movieContents: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading){
                ForEach(Array(contentTitles.shuffled().enumerated()), id: \.offset){ index, title in
                    
                    ListTitleView(title: title, animationDelay: .constant(0.729 + Double(index) * 0.29))
                        .padding(.top, index == 0 ? 14.729 : 2.297)
                        .offset(z: 1)
                        .saturation(selectionListId == -1 ? 1 : 0.29)
                    
                    ContentListView(
                        selectedContent: $selectedContent,
                        selectionListId: $selectionListId,
                        listId: index,
                        animationDelay: 1.297 + Double(index) * 0.729,
                        contents: Array(contents.shuffled()[0..<5])
                    )
                    .padding(.vertical, -75)
                }
            }
        }
        .padding(.top, 329)
    }
    private var browseByContents: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading){
                HStack{
                    Text("Browse By Languages")
                        .font(.title)
                        .padding(.leading)
                    Spacer()
                    Picker("Select Your References", selection: .constant(0)) {
                        Text("Original Language")
                            .font(.headline)
                    }
                    .pickerStyle(.menu)
                    Picker("", selection: .constant(0)) {
                        Text("English")
                            .font(.headline)
                    }
                    .pickerStyle(.menu)
                    Picker("Sort By", selection: .constant(0)) {
                        Text("Suggestions For You")
                            .font(.headline)
                    }
                    .pickerStyle(.menu)
                    .padding(.trailing)
                }
                .foregroundStyle(.white)
                
                ForEach(Array(contentTitles.shuffled().enumerated()), id: \.offset){ index, title in
                    
                    ContentListView(
                        selectedContent: $selectedContent,
                        selectionListId: $selectionListId,
                        listId: index,
                        animationDelay: 1.297 + Double(index) * 0.729,
                        contents: Array(contents.shuffled()[0..<5])
                    )
                    .padding(.vertical, -75)
                }
            }
        }
        .padding(.top, 29)
    }
}

#Preview {
    ContentsView(contents: .constant(ContentAPI().contents), selectedContent: .constant(nil), selectionListId: .constant(-1), selectedMenu: .constant(.home))
}
