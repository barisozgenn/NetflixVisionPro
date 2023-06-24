//
//  ContentListView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 24.06.2023.
//

import SwiftUI

struct ContentListView: View {
   
    @Binding var selectionListId: Int
    let listId: Int
    let animationDelay: Double
    
    @State private var selectionId: Int = 0
    
    @State private var rectSize: (Double, Double) = (0, 0)
    @State private var selectedItem: Int = -1
    var body: some View {
        ScrollView(.horizontal){
            ZStack{
                ForEach((0...30), id: \.self) {i in
                    ContentCellView(itemId: i,
                                    selectedItem: $selectedItem,
                                    selectionListId: $selectionListId, listId: listId,
                                    animationDelay: animationDelay + (Double(i) * 0.229),
                                    rectSize: $rectSize)
                    .tag(i)
                }
            }
            .frame(height: rectSize.1 + 129 + 29, alignment: .center)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.never)
        .onAppear(perform: {
            withAnimation(.smooth().delay(animationDelay)){
                rectSize = (192.0, 132.0)
            }
        })
        
    }
}

#Preview {
    ContentListView(selectionListId: .constant(0), listId: 0, animationDelay: 0)
}

struct ContentCellView: View {
    
    let itemId: Int
    @Binding var selectedItem : Int
    @Binding var selectionListId: Int
    let listId: Int
    
    let animationDelay: Double
    @Binding var rectSize : (Double, Double)
    
    @State private var scale : Double = 0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill( selectedItem != itemId ?  .black : .red)
            .padding(2)
            .frame(width: selectedItem != itemId ? rectSize.0 : (rectSize.0 + 50), height: selectedItem != itemId ? rectSize.1 : (rectSize.1 + 129))
            .clipped()
            .scaleEffect(scale)
            .opacity(scale)
            .overlay(Text("\(itemId)"))
            .onAppear{
                withAnimation(.smooth().delay(animationDelay)){
                    scale = 1
                }
            }
            .onTapGesture {
                withAnimation(.smooth){
                    selectionListId = listId
                    if selectedItem == itemId {
                        selectedItem = -1
                    }else {
                        selectedItem = itemId
                    }
                }
            }
            .onChange(of: selectionListId) { oldS, newS in
                if newS != listId {
                    selectedItem = -1
                }
            }
            .hoverEffect(.lift)
            .offset(x: rectSize.0 * Double(itemId))
            .offset(z: selectedItem != itemId ? 0 : 72.92)
        
        
    }
}
