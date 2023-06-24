//
//  String.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 24.06.2023.
//

import SwiftUI

extension String {
    func convertBase64ToNSImage () -> UIImage {
        guard let imageData = Data(base64Encoded: self) else {return UIImage(imageLiteralResourceName: "netflix-clone-swifui-barisozgen–app") }
        let image = UIImage(data: imageData) ?? UIImage(imageLiteralResourceName: "netflix-clone-swifui-barisozgen–app")
            return image
        
        
    }
}
