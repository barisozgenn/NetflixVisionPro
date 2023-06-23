//
//  AVPlayerPresented.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 23.06.2023.
//


import SwiftUI
import AVFoundation
import AVKit

struct PlayerViewRepresentable: UIViewControllerRepresentable {
    
    var videoPlayer : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = videoPlayer
        controller.showsPlaybackControls = false
        //controller.player?.replaceCurrentItem(with: AVPlayerItem(url: itemURL))

        return controller
    }
    func updateUIViewController(_ : AVPlayerViewController, context: Context) {
    }
}

