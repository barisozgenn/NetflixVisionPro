//
//  ListTitleView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 24.06.2023.
//

import SwiftUI

struct ListTitleView: View {
    @State var isListHover: Bool = false
    @State private var isHeaderHover: Bool = false
    @State private var offsetY = -14.0
    @State private var opacity: Double = 0.0
    
    let title: String
    @Binding var animationDelay: Double
        
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack(alignment: .bottom, spacing: 0){
                Text(title)
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding(.leading, 7)
                Text("Explore All")
                    .font(.headline)
                    .frame(width: isHeaderHover ? 92 : 0, height: 18)
                    .scaleEffect(x: isHeaderHover ? 1 : 0)
                    .opacity(isHeaderHover ? 1 : 0)
                    .padding(.leading, isHeaderHover ? 7 : 0)
                    .padding(.bottom, 1)
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .opacity(isHeaderHover || isListHover ? 1 : 0)
                    .padding(.leading, 7)
                    .padding(.bottom, 4)
                Spacer()
            }
            .foregroundStyle(.white.opacity(0.729))
            .fontWeight(.semibold)
            .padding(.horizontal)
            .onTapGesture {
                withAnimation(.spring()){
                    isHeaderHover.toggle()
                }
            }
        })
        .offset(y: offsetY)
        .opacity(opacity)
        .onAppear{
            withAnimation(.smooth.delay(animationDelay)){
                offsetY = 0
                opacity = 1
            }
        }
    }
}

#Preview {
    ListTitleView(title: "List Title",animationDelay: .constant(0))
}


