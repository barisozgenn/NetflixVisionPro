//
//  ContentCellView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 25.06.2023.
//

import SwiftUI

struct ContentCellView: View {
    let content: ContentModel
    let itemId: Int
    @Binding var selectedItem : Int
    @Binding var selectionListId: Int
    let listId: Int
    
    let animationDelay: Double
    @Binding var rectSize : (Double, Double)
    
    @State private var scale : Double = 0
    @State private var image: UIImage = UIImage(systemName: "photo.artframe")!
    @State private var categories: String = ""
    @State private var backgroundOpacity : Double = 0
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        Button(action: {
            withAnimation(.smooth){
                selectionListId = listId
                if selectedItem == itemId {
                    selectedItem = -1
                    backgroundOpacity = 0
                }else {
                    selectedItem = itemId
                    backgroundOpacity = 0.92
                }
            }
        }, label: {
            VStack(spacing: 0){
                // content image and video
                imageView
                
                if selectedItem == itemId {
                    VStack(alignment: .leading, spacing: 0){
                        linearGradient
                        // content control buttons
                        contentControlButtons
                        // content description
                        contentDescription
                        
                        // content categories
                        contentCategories
                    }
                    
                }
            }
            .background(.black.opacity(backgroundOpacity))
            .frame(width: selectedItem != itemId ? rectSize.0 : (rectSize.0 + 50), height: selectedItem != itemId ? rectSize.1 : (rectSize.1 + 129))
            .scaleEffect(scale)
            .opacity(scale)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .hoverEffect(.lift)
        })
        .buttonStyle(.plain)
        .onAppear{
            withAnimation(.smooth().delay(animationDelay)){
                scale = 1
            }
        }
        .onChange(of: selectionListId) { oldS, newS in
            if newS != listId {
                selectedItem = -1
                backgroundOpacity = 0
            }
        }
        .offset(x: (rectSize.0 * Double(itemId)) + Double(itemId) + 2.29)
        .offset(z: selectedItem != itemId ? 0 : 72.92)
        
        
    }
    
    private var imageView: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: rectSize.0, height: selectedItem == itemId ? rectSize.1 + 24 : rectSize.1)
            .onAppear{
                withAnimation(.spring()){
                    image = content.imageBase64.convertBase64ToNSImage()
                }
            }
    }
    private var contentControlButtons: some View {
        HStack{
            Image(systemName: "play.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .padding(12)
                .foregroundStyle(.black)
                .background(.white)
                .clipShape(Circle())
            
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .padding(12)
                .foregroundStyle(.white)
                .background(Circle().fill(.thinMaterial).stroke(Color(.lightGray)))
            Image(systemName: "hand.thumbsup")
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .padding(12)
                .foregroundStyle(.white)
                .background(Circle().fill(.thinMaterial).stroke(Color(.lightGray)))
            Spacer()
            Button {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "selectedContent"), object: content)
                withAnimation(.smooth()){
                    print("pressed open window")
                    openWindow(id: "content-expanded-window")
                }
            } label: {
                Image(systemName: "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .padding(16)
                    .foregroundStyle(.white)
                    .background(Circle().fill(.thinMaterial).stroke(Color(.lightGray)))
            }
            .buttonStyle(.plain)

        }
        .padding(.bottom, 14)
        .padding(.top, -14)
        .padding(.horizontal,7)
    }
    private var contentDescription: some View {
        HStack{
            Text("\(content.match)%")
                .foregroundStyle(.green)
                .font(.headline)
            Text(content.maturityRatings.first ?? "+7")
                .padding(2)
                .padding(.horizontal,5)
                .background(Rectangle().fill(.thinMaterial).stroke(Color(.lightGray)))
            Text(content.year)
                .padding(2)
            Text("HD")
                .padding(2)
                .padding(.horizontal,6)
                .background(Rectangle().fill(.thinMaterial).stroke(Color(.lightGray)))
        }
        .font(.subheadline)
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .padding(.horizontal,7)
    }
    private var contentCategories: some View {
        Text(categories)
            .font(.subheadline)
            .fontWeight(.regular)
            .padding(.vertical, 7)
            .padding(.horizontal,7)
            .onAppear{
                var cats = ""
                content.categories.forEach { category in
                    cats += "\(category) • "
                }
                categories = String(cats.dropLast(3))
            }
    }
    private var linearGradient: some View {
        LinearGradient(colors: [.black.opacity(0.92), .black, .black.opacity(0.5), .black.opacity(0)], startPoint: .top, endPoint: .bottom)
            .frame(height: 70)
            .padding(.top, -24)
            .padding(.bottom, -70)
    }
}
/*

#Preview {
    ContentCellView(content: ContentAPI().contents[0], itemId: 0, selectedItem: .constant(0), selectionListId: .constant(0), listId: 0, animationDelay: 0, rectSize: .constant((229.0, 132.0)))
}*/
