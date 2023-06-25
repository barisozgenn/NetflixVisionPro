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

    @State private var scale = 0.0
    @State private var offsetY = 329.0
    @State private var offsetX = 329.0
    private let contentTitles: [String] = ["Trending Now","Top Picks For You", "Only on Netflix","Watch In One Weekend"]
    
    @State private var selectionListId: Int = 0
    
    var body: some View {
        ZStack{
            ScrollView(.vertical) {
                ContentHeaderVideoPlayer(headerContent: contents[0], selectedContent: $selectedContent)
                linearGradient
                VStack(alignment: .leading){
                    ForEach(Array(contentTitles.enumerated()), id: \.offset){ index, title in
                        ListTitleView(title: title, animationDelay: .constant(3.729 + Double(index) * 0.29))
                            .offset(z: 1)
                        ContentListView(
                            selectedContent: $selectedContent,
                            selectionListId: $selectionListId,
                            listId: index,
                            animationDelay: 5.297 + Double(index) * 0.729,
                            contents: contents.shuffled()
                        )
                        .padding(.vertical, -75)
                    }
                }
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
            .padding(.top, -20)
            .padding(.bottom, -70)
    }
}

#Preview {
    ContentsView(contents: .constant(ContentAPI().contents), selectedContent: .constant(nil))
}
