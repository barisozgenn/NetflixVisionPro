//
//  SelectedContent.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 25.06.2023.
//

import Foundation
struct SelectedContent {
    let content: ContentModel
    let flowType: EFlowType
}
enum EFlowType: Int, CaseIterable, Identifiable {
    case expanded
    case play
    
    var id : Int { return rawValue}
    
}
