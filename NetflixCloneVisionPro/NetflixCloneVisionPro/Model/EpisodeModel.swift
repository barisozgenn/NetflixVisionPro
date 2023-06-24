//
//  EpisodeModel.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 24.06.2023.
//

import Foundation

// MARK: - Episodes
struct EpisodeModel: Identifiable, Codable {
    let id: String
    let episodeDescription: String
    let durationInMinute: Int
    let videoURL: String
}
