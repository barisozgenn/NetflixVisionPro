//
//  ContentHeaderVideoPlayer.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 23.06.2023.
//

import SwiftUI
import AVKit

struct ContentHeaderVideoPlayer: View {
    @Environment(\.supportsMultipleWindows) private var supportsMultipleWindows
    @Environment(\.openWindow) var openWindow
    var headerContent: ContentModel
    @Binding var selectedContent: SelectedContent?

    
    @State private var isFocused = true
    @State private var isHeaderVideoSelected = false
    @State private var headerVideoPlayer = AVPlayer(url: Bundle.main.url(forResource: "example-video", withExtension: "mp4")!)
    @State private var isVideoMuted = true
    var body: some View {
        ZStack(alignment: .topLeading){
            videoPlayerView
            infoView
        }
        .fontWeight(.semibold)
        .frame(width: 840, height: 329)
        .foregroundStyle(.white)
        .clipped()
        .onTapGesture {
            withAnimation(.spring()){
                isFocused.toggle()
            }
        }
    }
    
    private var videoPlayerView: some View {
        PlayerViewRepresentable(videoPlayer: headerVideoPlayer)
            .frame(width: 844, height: 500)
            .disabled(true)
            .background(.purple)
            .hoverEffect(.lift, isEnabled: isFocused)
            .onAppear{
                //headerVideoPlayer.play()
                headerVideoPlayer.isMuted = isVideoMuted
                headerVideoPlayer.actionAtItemEnd = .none
            }
            .onTapGesture {
                headerVideoPlayer.play()
            }
    }
    private var infoView: some View {
        HStack{
            VStack(alignment: .leading,spacing: 0){
                // type of content
                HStack{
                    Image("img-netflix-logo-letter")
                        .resizable()
                        .scaledToFit()
                        .frame(height: isFocused ? 24 : 36)
                        .opacity(0.92)
                    Text("SERIES")
                        .font(isFocused ? .headline : .title3)
                        .foregroundStyle(.thinMaterial)
                    
                }
                // content logo and description
                VStack(alignment: .leading){
                    Image("example-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: isFocused ? 58 : 72)
                        .opacity(0.92)
                        .foregroundStyle(.white)
                        .padding(.top, 7)
                    
                    
                    Text("Arnold revisits his upbringing in post-war Austria, the moment that sparked his seismic rise to bodybuilding fame and his pursuit of the American dream.")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .opacity(isFocused ? 1 : 0)
                        .frame(height: isFocused ? 100 : 0)
                        .frame(width: 258)
                        .shadow(color: .black.opacity(0.92), radius: 2, x: 1, y: 1)
                }
                // content buttons
                HStack{
                    Button {
                        withAnimation(.smooth()){
                            isHeaderVideoSelected.toggle()
                            selectedContent = SelectedContent(content: headerContent, flowType: .play)
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
                        .hoverEffect(.lift)
                    }
                    .buttonStyle(.plain)
                    .disabled(!supportsMultipleWindows)
                    
                    Button {
                        withAnimation(.smooth()){
                            selectedContent = SelectedContent(content: headerContent, flowType: .expanded)
                        }
                    } label: {
                        HStack{
                            Image(systemName: "info.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(height: isFocused ? 24 : 20)
                                .opacity(0.92)
                                .foregroundStyle(.white)
                            Text("More Info")
                                .font(isFocused ? .title2 : .title3)
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal)
                        .padding(.vertical,7)
                        .background(.thinMaterial)
                        .cornerRadius(7)
                        .padding(.vertical, isFocused ? 20 : 0)
                        .hoverEffect(.lift)
                    }
                    .buttonStyle(.plain)
                    .disabled(!supportsMultipleWindows)
                   
                }
            }
            .padding(.horizontal)
            Spacer()
            HStack{
                // volume
                Image(systemName: isVideoMuted ? "speaker.slash" : "speaker.wave.3")
                    
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .opacity(0.92)
                    .padding(12)
                    .background(Circle().stroke(.white, lineWidth: 2).fill(.ultraThinMaterial))
                    .onTapGesture {
                        withAnimation(.spring()){
                            isVideoMuted.toggle()
                            headerVideoPlayer.isMuted = isVideoMuted
                        }
                       
                    }
                HStack{
                    Rectangle()
                        .fill(.white)
                        .frame(width: 7, height: 40)
                    Text("7+")
                        .padding(.leading, 7)
                        .padding(.trailing, 92)
                        .font(.title2)
                }
                .background(.thinMaterial)
                .padding(.trailing, -29)
                
            }
            .foregroundStyle(.white)
        }
        .padding(.horizontal)
        .padding(.top, isFocused ? 129 : 158)
    }
    
}


#Preview {
    ContentHeaderVideoPlayer(headerContent: ContentAPI().contents[0], selectedContent: .constant(nil))
}
