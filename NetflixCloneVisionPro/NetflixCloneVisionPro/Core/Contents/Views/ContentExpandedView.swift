//
//  ContentExpandedView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 25.06.2023.
//

import SwiftUI

struct ContentExpandedView: View {
    @Environment(\.dismiss) var dismiss
    let contentModel : ContentAPI
    
    @State private var isFocused = true
    @State private var isHeaderVideoSelected = false
    @State private var cast: String = ""
    @State private var genres: String = ""
    @State private var thisIs: String = ""
    @State private var image: UIImage = UIImage(systemName: "photo.artframe")!

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
 /*   private var videoPlayerView : some View {
        ZStack{
            PlayerViewRepresentable(videoPlayer: viewModel.videoPlayer)
                .frame(maxWidth: viewModel.videoFrame.width, maxHeight: viewModel.videoFrame.height)
                .disabled(true)
                .background(.purple)
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: viewModel.videoFrame.width, maxHeight: viewModel.videoFrame.height)
                .onAppear{setupHeader()}
                .opacity(viewModel.imageOpacity)
                .onChange(of: viewModel.content) { _ in setupHeader()}
        }
        
    }
    private var closeMarkView: some View{
        VStack{
            HStack{
                Spacer()
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .foregroundColor(Color(.darkGray))
                    .background(.white)
                    .clipShape(Circle())
                    .withPlayerButtonModifier(frameHeight: 27)
                    .onTapGesture { withAnimation(.spring()){
                        //dismiss()
                        NSApplication.shared.windows.first(where: {$0.identifier?.rawValue ?? "" == "content-expanded-window"})?.performClose(nil)
                        viewModel.videoPlayer.pause()
                    }}
            }
            .padding()
            Spacer()
        }
    }
    private var contentDetailView:some View{
        // content description
        HStack{
            if let content = viewModel.content {
                VStack(alignment: .leading){
                    HStack{
                        Text("\(content.match)% Match")
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                            .font(.title3)
                        Text(content.maturityRatings.first ?? "7+")
                            .padding(2)
                            .padding(.horizontal)
                            .background(Rectangle().stroke(Color(.lightGray)))
                        Text(content.year)
                            .padding(2)
                        Text("HD")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(2)
                            .padding(.horizontal,6)
                            .background(Rectangle().stroke(Color(.lightGray)))
                    }
                    Text(content.episodes.first?.episodeDescription ?? "baris lorem ipsum")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .navigationTitle(content.name)
            }
            Spacer()
            if let content = viewModel.content{
                VStack(alignment: .leading){
                    // cast
                    HStack(alignment: .top){
                        Text("Cast:")
                            .foregroundColor(.gray)
                        Text(cast)
                            .onAppear{
                                var items = ""
                                content.artists.forEach { item in
                                    items += "\(item), "
                                }
                                cast = String(items.dropLast(2))
                            }
                    }
                    // genres
                    HStack(alignment: .top){
                        Text("Genres:")
                            .foregroundColor(.gray)
                        Text(genres)
                            .onAppear{
                                var items = ""
                                content.genres.forEach { item in
                                    items += "\(item), "
                                }
                                genres = String(items.dropLast(2))
                            }
                    }
                    // this movie is
                    HStack(alignment: .top){
                        Text("This movie is:")
                            .foregroundColor(.gray)
                        Text(thisIs)
                            .onAppear{
                                var items = ""
                                content.categories.forEach { item in
                                    items += "\(item), "
                                }
                                thisIs = String(items.dropLast(2))
                            }
                    }
                }}
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding()
    }
    private var contentButtonsView: some View{
        HStack{
            VStack(alignment: .leading,spacing: 0){
                // content buttons
                HStack{
                    HStack{
                        Image(systemName: "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: isFocused ? 24 : 20)
                            .opacity(0.92)
                            .foregroundColor(.black)
                        
                        Text("Play")
                            .font(isFocused ? .title2 : .title3)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    .padding(.vertical,7)
                    .background(.white)
                    .cornerRadius(7)
                    .onTapGesture {
                        withAnimation(.spring()){
                            isHeaderVideoSelected.toggle()
                            //dismiss()
                            NSApplication.shared.windows.first(where: {$0.identifier?.rawValue ?? "" == "content-expanded-window"})?.performClose(nil)
                            viewModel.videoPlayer.pause()
                        }
                    }
                    .sheet(isPresented: $isHeaderVideoSelected) {
                        PlayerView()
                            .presentationDragIndicator(.visible)
                    }
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
                    Image(systemName: "hand.thumbsup")
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
                    Spacer()
                    // volume
                    Image(systemName: "speaker.wave.3")
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
            }
            .padding(.horizontal)
            
        }
        .padding(.horizontal)
        .padding(.bottom, 29)
    }
    private var listView: some View{
        VStack(alignment:.leading){
            Text("More Like This")
                .foregroundColor(.white)
                .font(.title)
                .padding(.horizontal)
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(viewModel.contents, id: \.self) { item in
                    ContentExpandedCell(content: item)
                }
            }
            .padding(.horizontal)
        }
    }
    func setupHeader(){
        if let content = viewModel.content {
            image = content.imageBase64.convertBase64ToNSImage()
        }
        withAnimation(.easeIn(duration: 2).delay(1)){viewModel.imageOpacity=0}
    }*/
}

#Preview {
    ContentExpandedView(contentModel: ContentAPI())
}
