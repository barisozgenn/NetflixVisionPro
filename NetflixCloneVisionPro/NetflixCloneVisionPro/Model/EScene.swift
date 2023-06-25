//
//  EScene.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 25.06.2023.
//

import Foundation
enum EScene: Int, CaseIterable, Identifiable {
    case contentsHome
    case expandedContent
    case mainPlayer
    
    var id : Int { return rawValue}
}
