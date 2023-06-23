//
//  MenuBarItemView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 23.06.2023.
//

import SwiftUI

struct MenuBarItemView: View {
    let menu: EMenu
    @Binding var selectedMenu: EMenu
    @Binding var animationDelay: Double
    @State private var foregroundColor : Color = .white
    @State private var offsetX = -229.0
    @State private var opacity: Double = 0.0
    var body: some View {
        
        Button(action: {
            withAnimation(.smooth){
                selectedMenu = menu
            }
        }, label: {
            Text(menu.title)
                .foregroundStyle(foregroundColor)
                .fontWeight( .bold)
                .font(.system(size: 25))
        })
        .padding(.vertical,7)
        .offset(x: offsetX)
        .opacity(opacity)
        .onAppear{
            withAnimation(.smooth.delay(animationDelay)){
                offsetX = 0
                opacity = 1
            }
        }
    }
}


#Preview {
    MenuBarItemView(menu: .home, selectedMenu: .constant(.home), animationDelay: .constant(2.29))
}
