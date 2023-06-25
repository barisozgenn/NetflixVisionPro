//
//  MainPlayerView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 24.06.2023.
//

import SwiftUI

struct MainPlayerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedContent: SelectedContent?

    private let viewModel = PlayerViewModel()
    
    
    @State private var isControlPanelVisible = false
    @State private var isFullScreen = false
    @State private var isVolumeHover = false
    @State private var isDissmiss = false
    
    @State private var videoCurrentTime : Double = 0
    @State private var videoVolume : Double = 1

    var body: some View {
        ZStack{
            videoPlayerView
            controlPanelView
        }
        .frame(minWidth: viewModel.videoFrame.width,
               idealWidth: viewModel.videoFrame.width,
               maxWidth: viewModel.videoFrame.width,
               minHeight: viewModel.videoFrame.height,
               idealHeight: viewModel.videoFrame.height,
               maxHeight: viewModel.videoFrame.height)
        .scaleEffect(isDissmiss ? 0 : 1)
        .onTapGesture{withAnimation(.spring()){isControlPanelVisible.toggle()}}
    }
    private var videoPlayerView : some View {
        PlayerViewRepresentable(videoPlayer: viewModel.videoPlayer)
            .frame(maxWidth: .infinity)
            .disabled(true)
            .background(.purple)
            .onAppear{
                withAnimation(.spring()){isControlPanelVisible=true}
            }
            .onChange(of: viewModel.videoCurrentTime){
                videoCurrentTime = viewModel.videoCurrentTime
            }
    }
    private var controlPanelView: some View {
        VStack(spacing:20){
            HStack{
                Image(systemName: "arrow.left")
                    .scaledToFit()
                    .frame(height: 24)
                    .onTapGesture {
                        viewModel.videoPlayStop()
                        withAnimation(.spring()){isDissmiss.toggle()}
                        withAnimation(.easeOut(duration: 3).delay(3)){
                            selectedContent = nil
                            dismiss()
                        }
                    }
                Spacer()
                Image(systemName: "flag")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
            }
            .padding(.horizontal)
            Spacer()
            HStack{
                Slider(value: $videoCurrentTime, in: 0...viewModel.videoTotalSeconds)
                    .tint(.red)
                    .foregroundColor(.red)
                Text("\(viewModel.videoDuration)")
                    .font(.headline)
            }
            .opacity(viewModel.videoCurrentTime < 1 || isVolumeHover ? 0.07 : 1)
            HStack{
                HStack(spacing:29){
                    Image(systemName: viewModel.videIsPlaying ? "pause.fill" : "play.fill")
                        .onTapGesture { viewModel.videoPlayStop() }
                    Image(systemName: "gobackward.10")
                        .onTapGesture { viewModel.videoChangeTime(isForward: false) }
                    Image(systemName: "goforward.10")
                        .onTapGesture { viewModel.videoChangeTime() }
                    Image(systemName: videoVolume > 0.8  ? "speaker.wave.3.fill" :
                            videoVolume > 0.5  ? "speaker.wave.2.fill" :
                            videoVolume > 0.1  ? "speaker.wave.1.fill" : "speaker.slash.fill")
                    .onTapGesture { withAnimation(.spring()){isVolumeHover.toggle()} }
                    VStack{
                        Slider(value: $videoVolume, in: 0...1)
                            .tint(.red)
                            .frame(width: 129, height: 40)
                            .padding(4)
                            .background(Color(.darkGray))
                            .rotationEffect(.degrees(-90.0))
                            .onChange(of: videoVolume) {oldVol,  newVol in
                                withAnimation(.spring()){viewModel.setVideoVolume(newVol)} }
                    }
                    .padding(.leading, -114)
                    .padding(.top, -129)
                    .opacity(isVolumeHover ? 1 : 0)
                }
                Text("Content title: Episode title")
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                HStack(spacing:29){
                    Image(systemName: "forward.end")
                    Image(systemName: "rectangle.on.rectangle")
                    Image(systemName: "text.bubble")
                    Image(systemName: "stopwatch")
                    Image(systemName: "rectangle.dashed")
                        .onTapGesture {
                            withAnimation(.spring()){
                                viewModel.isFrameFullScreen.toggle()
                            }
                        }
                }
            }
            .shadow(color: .black.opacity(0.29), radius: 3, x: 1, y: 1)
            .fontWeight(.bold)
            .padding(.bottom, 14)
        }
        .scaleEffect(y: isControlPanelVisible ? 1 : 1.29)
        .opacity(isControlPanelVisible ? 1 : 0)
        .foregroundColor(.white)
        .padding()
        .background(content: {
            LinearGradient(colors: [.black.opacity(0.92),
                                    .clear,
                                    .clear,
                                    .clear,
                                    .clear,
                                    .clear,
                                    .black.opacity(0.92)], startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
        })
    }
}


#Preview {
    MainPlayerView(selectedContent: .constant(nil))
}
