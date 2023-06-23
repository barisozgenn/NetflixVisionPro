//
//  EMenu.swift
//  NetflixVisionPro
//
//  Created by Baris OZGEN on 22.06.2023.
//
enum EMenu: Int, CaseIterable, Identifiable {
    case home
    case tvShows
    case movies
    case newAndPopular
    case myList
    case browseByLanguages
    
    var id : Int { return rawValue}
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .tvShows:
            return "TV Shows"
        case .movies:
            return "Movies"
        case .newAndPopular:
            return "New & Popular"
        case .myList:
            return "My List"
        case .browseByLanguages:
            return "Browse By ..."
        }
    }
}


