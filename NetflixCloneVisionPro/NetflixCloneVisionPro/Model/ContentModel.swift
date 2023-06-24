//
//  ContentModel.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 24.06.2023.
//


struct ContentModel: Identifiable, Codable {
    let id: String
    let name, imageBase64: String
    let maturityRatings, genres, categories: [String]
    let year: String
    let artists: [String]
    let match: String
    let episodes: [EpisodeModel]
}
