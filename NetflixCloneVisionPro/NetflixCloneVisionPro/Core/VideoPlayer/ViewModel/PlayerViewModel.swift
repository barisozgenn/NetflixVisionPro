//
//  PlayerViewModel.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 24.06.2023.
//

import AVKit
import SwiftUI
import Observation

@Observable class PlayerViewModel {
    private let randomDemoVideos = [
        URL(string: "https://v4.cdnpk.net/videvo_files/video/free/video0464/large_watermarked/_import_612333a5b77665.41253489_FPpreview.mp4")!,
        URL(string: "https://v4.cdnpk.net/videvo_files/video/free/video0464/large_watermarked/_import_612725328cbc79.49168812_FPpreview.mp4")!,
        URL(string: "https://v4.cdnpk.net/videvo_files/video/free/video0460/large_watermarked/_import_60d5777e472e47.79267516_FPpreview.mp4")!,
        URL(string: "https://v4.cdnpk.net/videvo_files/video/free/video0466/large_watermarked/_import_614ebc62e143a4.87970316_FPpreview.mp4")!,
        URL(string: "https://v4.cdnpk.net/videvo_files/video/free/video0467/large_watermarked/_import_615579a59b5687.27049363_FPpreview.mp4")!,
        URL(string: "https://v4.cdnpk.net/videvo_files/video/free/video0471/large_watermarked/_import_618a60f421e389.11686272_FPpreview.mp4")!]
    
    
    private var timeObserverToken: Any? = nil
    
    let videoPlayer : AVPlayer
    var videoDuration : String = "00:00:00"
    var videoCurrentTime : Double = 0
    var videoTimeLeft : Double = 1
    var videoTotalSeconds : Double = 1
    var videIsPlaying: Bool = true
    var videoFrame : (width: CGFloat, height: CGFloat) = (1000,566)
    var isFrameFullScreen : Bool = false
    
    init(){
        videoPlayer = AVPlayer(url: Bundle.main.url(forResource: "netflix-intro-for-movie", withExtension: "mp4")!)
        videoPlayer.actionAtItemEnd = .pause
        // first show demo netflix video than select a random demo movie
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: videoPlayer.currentItem)
        videoPlayer.play()
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        removePeriodicTimeObserver()
        videoPlayer.seek(to: CMTime.zero)
        videoPlayer.replaceCurrentItem(with: AVPlayerItem(url: randomDemoVideos.randomElement()!))
        videoPlayer.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
            let totalSeconds = self.videoPlayer.currentItem?.duration.seconds ?? 0
            self.videoCurrentTime = 0
            self.videoTotalSeconds = totalSeconds
            self.videoTimeLeft = totalSeconds
            let (hh,mm,ss) = self.modifyVideoTime(totalSeconds)
            self.videoDuration = "\(hh):\(mm):\(ss)"
            self.addPeriodicTimeObserver()
        }
    }
    
    private func modifyVideoTime(_ seconds: Double) -> (String,String,String) {
        let secondsInt = seconds.toInt() ?? 0 //Int(seconds)
        let (h,m,s) = (secondsInt / 3600, (secondsInt % 3600) / 60, (secondsInt % 3600) % 60)
        let hh = h < 10 ? "0\(h)" : String(h)
        let mm = m < 10 ? "0\(m)" : String(m)
        let ss = s < 10 ? "0\(s)" : String(s)
        return (hh,mm,ss)
    }
    
    func addPeriodicTimeObserver() {
        // Notify every second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.29, preferredTimescale: timeScale)
        
        timeObserverToken = videoPlayer.addPeriodicTimeObserver(forInterval: time,
                                                                queue: .main) {
            [weak self] time in
            // update player transport UI
            self?.videoCurrentTime = time.seconds
            self?.updateVideoDuration()
            self?.setFrameSize()
        }
    }
    
    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            videoPlayer.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
    
    func updateVideoDuration(){
        videoTimeLeft = videoTotalSeconds - videoCurrentTime
        if videoTimeLeft > 0 {
            let (hh,mm,ss) = modifyVideoTime(videoTimeLeft)
            videoDuration = "\(hh):\(mm):\(ss)"
        }
    }
    
    func videoPlayStop(){
        withAnimation(.spring()){
            if videIsPlaying {
                videoPlayer.pause()
                videIsPlaying = false
            }else {
                videoPlayer.play()
                videIsPlaying = true
            }
        }
    }
    
    func videoChangeTime(isForward: Bool = true){
        let nextSeconds = isForward ? videoCurrentTime+5 : videoCurrentTime-5
        let timeCM = CMTime(seconds: nextSeconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        videoPlayer.seek(to: timeCM)
        
    }
    
    func setVideoVolume(_ videoVolume:Double){
        videoPlayer.volume = Float(videoVolume)
    }
    
    func setFrameSize(){
        /*let frameSize = videoPlayer.currentItem!.presentationSize
         let fullScreenSize : (width: CGFloat, height: CGFloat) = ( UIScene.main!.frame.width, NSScreen.main!.frame.width)
         
         withAnimation(.spring()){
         videoFrame = isFrameFullScreen ? fullScreenSize : (frameSize.width, frameSize.height)
         }*/
    }
}
