//
//  ContentExpandedView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 25.06.2023.
//

import SwiftUI
import AVKit

struct ContentExpandedView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedContent: SelectedContent?
    @Binding var contents: [ContentModel]
    @Binding var selectionListId: Int
    
    @State private var isFocused = true
    @State private var cast: String = ""
    @State private var genres: String = ""
    @State private var thisIs: String = ""
    @State private var image: UIImage = UIImage(systemName: "photo.artframe")!
    @State private var saturation = 0.0
    @State private var isHeaderVideoSelected = false
    @State private var headerVideoPlayer = AVPlayer()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView{
            VStack{
                ZStack(alignment: .bottom){
                    videoPlayerView
                    closeMarkView
                }
                linearGradient
                contentButtonsView
                contentDetailView
                listView
                Spacer()
            }
        }
        .background(.black.opacity(0.729))
        .saturation(saturation)
        .frame(width: 629)
    }
    private var videoPlayerView : some View {
        ZStack{
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 220)
                .onAppear{
                    if let content = selectedContent?.content {
                        image = content.imageBase64.convertBase64ToNSImage()
                        
                        // here is for demo video showcase
                        if content.id == "1bar" {
                            headerVideoPlayer.replaceCurrentItem(with: AVPlayerItem(url: Bundle.main.url(forResource: "example-mehmed", withExtension: "mp4")!))
                           
                        }else if content.id == "2bar" {
                            headerVideoPlayer.replaceCurrentItem(with: AVPlayerItem(url: Bundle.main.url(forResource: "example-bill", withExtension: "mp4")!))
                        }else {
                            headerVideoPlayer.replaceCurrentItem(with: AVPlayerItem(url: Bundle.main.url(forResource: "example-video", withExtension: "mp4")!))
                        }
                    }
                }
                .onTapGesture {
                    withAnimation(.smooth()){
                        isHeaderVideoSelected.toggle()
                        headerVideoPlayer.play()
                        headerVideoPlayer.isMuted = false
                    }
                }
            PlayerViewRepresentable(videoPlayer: headerVideoPlayer)
                .frame(width: 629, height: 492)
                .disabled(true)
                .background(.purple)
                .hoverEffect(.lift)
                .opacity(isHeaderVideoSelected ? 1 :0)
                .onAppear{
                    //headerVideoPlayer.play()
                    headerVideoPlayer.actionAtItemEnd = .none
                    withAnimation(.smooth().delay(0.729)){
                        saturation = 1
                    }
                }
                .onTapGesture {
                    withAnimation(.smooth()){
                        headerVideoPlayer.pause()
                        isHeaderVideoSelected.toggle()
                        headerVideoPlayer.isMuted = true
                    }
                }
        }
        .frame(height: 292)
        .clipped()
        
    }
    private var closeMarkView: some View{
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    withAnimation(.smooth()){
                        saturation = 0
                    }
                    withAnimation(.smooth().delay(0.29)){
                        //dismiss()
                        selectionListId = -1
                        selectedContent = nil
                    }
                }, label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.thinMaterial)
                        .frame(width: 48)
                        .background(.white)
                        .clipShape(Circle())
                })
                .buttonStyle(.plain)
            }
            .padding()
            Spacer()
        }
    }
    private var contentDetailView:some View{
        // content description
        HStack{
            if let content = selectedContent?.content {
                VStack(alignment: .leading){
                    HStack{
                        Text("\(content.match)% Match")
                            .foregroundStyle(.green)
                            .fontWeight(.bold)
                            .font(.headline)
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
                        .foregroundStyle(.white)
                }
                .navigationTitle(content.name)
            }
            Spacer()
            if let content = selectedContent?.content{
                VStack(alignment: .leading){
                    // cast
                    HStack(alignment: .top){
                        Text("Cast:")
                            .foregroundStyle(.white.opacity(0.92))
                        Text(cast)
                            .foregroundStyle(.white)
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
                            .foregroundStyle(.white.opacity(0.92))
                        Text(genres)
                            .foregroundStyle(.white)
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
                            .foregroundStyle(.white.opacity(0.92))
                        Text(thisIs)
                            .foregroundStyle(.white)
                            .onAppear{
                                var items = ""
                                content.categories.forEach { item in
                                    items += "\(item), "
                                }
                                thisIs = String(items.dropLast(2))
                            }
                    }
                }
            }
        }
        .font(.caption)
        .foregroundStyle(.white)
        .padding()
        .shadow(color: .black, radius: 3, x:0, y:2)
    }
    private var contentButtonsView: some View{
        HStack{
            VStack(alignment: .leading,spacing: 0){
                // content buttons
                HStack{
                    Button {
                        withAnimation(.smooth()){
                                isHeaderVideoSelected = false
                                //dismiss()
                                if let content = selectedContent?.content {
                                    headerVideoPlayer.pause()
                                    selectedContent = SelectedContent(content: content, flowType: .play)
                                }
                            }
                    } label: {
                        HStack{
                            Image(systemName: "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: isFocused ? 24 : 20)
                                .opacity(0.92)
                                .foregroundStyle(.black)
                            
                            Text("Play")
                                .font(isFocused ? .title2 : .title3)
                                .foregroundStyle(.black)
                        }
                        .padding(.horizontal)
                        .padding(.vertical,7)
                        .background(.white)
                        .cornerRadius(7)
                    }
                    .buttonStyle(.plain)
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
        .padding(.top, -58)
    }
    private var listView: some View{
        VStack(alignment:.leading){
            Text("More Like This")
                .foregroundStyle(.white)
                .font(.title)
                .padding(.horizontal)
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(contents, id: \.id) { item in
                    ContentExpandedCell(content: item)
                }
            }
            .padding(.horizontal)
        }
    }
    private var linearGradient: some View {
        LinearGradient(colors: [.red, .red.opacity(0.5), .red.opacity(0)], startPoint: .top, endPoint: .bottom)
            .frame(height: 70)
    }
}

#Preview {
    ContentExpandedView(selectedContent: .constant(nil), contents: .constant(ContentAPI().contents), selectionListId: .constant(-1))
}
