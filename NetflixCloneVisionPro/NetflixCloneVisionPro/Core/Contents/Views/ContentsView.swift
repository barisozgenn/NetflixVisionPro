//
//  ContentsView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 23.06.2023.
//

import SwiftUI

struct ContentsView: View {
    @State private var scale = 0.0
    @State private var offsetY = 329.0
    @State private var offsetX = 329.0

    var body: some View {
        ZStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(content: {
            RoundedRectangle(cornerSize: CGSize(width: 14, height: 14))
                .fill(.thinMaterial)
        })
        .clipped()
        .padding(.leading, 258)
        .padding(.top, 72)
        .scaleEffect(y: scale)
        .offset(x: offsetX, y: offsetY)
        .onAppear{
            withAnimation(.smooth.delay(3.29)){
                offsetY = 0.0
                offsetX = 0.0
                scale = 1
            }
        }
    }
}

#Preview {
    ContentsView()
}
