//
//  ContentListView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 24.06.2023.
//

import SwiftUI

struct ContentListView: View {
    @Binding var selectedContent: SelectedContent?
    @Binding var selectionListId: Int
    let listId: Int
    let animationDelay: Double
    let contents: [ContentModel]
    
    @State private var selectionId: Int = 0
    
    @State private var rectSize: (Double, Double) = (0, 0)
    @State private var selectedItem: Int = -1
    
    
    var body: some View {
        ScrollView(.horizontal){
            ZStack{
                ForEach(Array(contents.enumerated()), id: \.offset) {i, content in
                    ContentCellView(selectedContent: $selectedContent,
                                    content: content, itemId: i,
                                    selectedItem: $selectedItem,
                                    selectionListId: $selectionListId, listId: listId,
                                    animationDelay: animationDelay + (Double(i) * 0.229),
                                    rectSize: $rectSize)
                    .tag(i)
                }
            }
            .frame(height: rectSize.1 + 129 + 29, alignment: .center)
            .padding(.leading, 7)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.never)
        .onAppear(perform: {
            withAnimation(.smooth().delay(animationDelay)){
                rectSize = (229.0, 132.0)
            }
        })
        
    }
}

#Preview {
    
    ContentListView(selectedContent: .constant(nil), selectionListId: .constant(0), listId: 0, animationDelay: 0, contents: ContentAPI().contents)
}
