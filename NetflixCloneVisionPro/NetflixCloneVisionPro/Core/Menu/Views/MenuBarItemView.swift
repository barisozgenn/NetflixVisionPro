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
    @State private var foregroundColor : Color = .white
    var body: some View {
        
        
        Text(menu.title)
            .foregroundStyle(foregroundColor)
            .fontWeight( .bold)
            .font(.system(size: 25))
            .onHover { hover in
                withAnimation(.spring()){
                    foregroundColor = hover ? .red : .white
                }
            }
            .onTapGesture {
                withAnimation(.smooth){
                    selectedMenu = menu
                }
            }
            .padding(.vertical,7)
        
    }
}


#Preview {
    MenuBarItemView(menu: .home, selectedMenu: .constant(.home))
}
