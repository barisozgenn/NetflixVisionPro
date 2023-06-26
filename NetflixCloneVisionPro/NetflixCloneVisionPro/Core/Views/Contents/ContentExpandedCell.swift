//
//  ContentExpandedCell.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 25.06.2023.
//

import SwiftUI


struct ContentExpandedCell: View {
    @State var isHover = false
    @State private var categories: String = ""
    @State private var image: UIImage = UIImage(systemName: "photo.artframe")!
    @State var content : ContentModel
    
    var body: some View {
        VStack{
           //imageView
            Image(uiImage: image)
                 .resizable()
                 .frame(maxWidth: 192, maxHeight: 129)
                 .background(.red)
                 .cornerRadius(4)
                 .onAppear{
                     withAnimation(.spring()){
                         image = content.imageBase64.convertBase64ToNSImage()
                     }
                 }
            contentDescription
            Spacer()
        }
        .frame(width: 192, height: 292)
        .background(.thinMaterial)
        .cornerRadius(4)
    }
}
extension ContentExpandedCell {
    private var imageView:some View{
        ZStack{
            // content image and video
           Image(uiImage: image)
                .resizable()
                .frame(maxWidth: 192, maxHeight: 129)
                .background(.red)
                .cornerRadius(4)
                .onAppear{
                    withAnimation(.spring()){
                        image = content.imageBase64.convertBase64ToNSImage()
                    }
                }
            // duration
            VStack{
                HStack{
                    Spacer()
                    Text(Double(content.episodes.first?.durationInMinute ?? 0).toHhMmSs(style: .brief))
                        .font(.headline)
                        .fontWeight(.semibold)
                        .shadow(color: .black, radius: 3, x:1, y:1)
                        .padding()
                }
                Spacer()
            }
            
            // play button
            Image(systemName: "play.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 14)
                .opacity(isHover ? 1: 0)
                .padding(12)
                .background {
                    Circle()
                        .strokeBorder(.white, lineWidth: 1.29)
                        .background(Circle().fill(.black.opacity(0.29)))
                }
        }
        //.frame(width: 192,height: 129)
        .onHover { hover in
            withAnimation(.spring()){isHover=hover}
        }
    }
    private var contentDescription:some View{
        VStack{
            // top
            HStack{
                VStack(alignment: .leading){
                    Text("\(content.match)% Match")
                        .foregroundStyle(.green)
                    HStack{
                        Text(content.maturityRatings.first ?? "7+")
                            .padding(2)
                            .padding(.horizontal, 4)
                            .background(Rectangle().stroke(Color(.lightGray)))
                        Text("\(content.year)")
                            .padding(2)
                    }
                }
                Spacer()
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 14)
                    .opacity(0.92)
                    .padding(12)
                    .background {
                        Circle()
                            .strokeBorder(.white, lineWidth: 1.29)
                            .background(Circle().fill(.black.opacity(0.29)))
                    }
            }
            // bottom
            Text(content.episodes.first?.episodeDescription ?? "lorem ipsum baris")
                .lineLimit(7)
                .padding(.top, 7)
        }
        .font(.subheadline)
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .padding(.horizontal)
    }
}
