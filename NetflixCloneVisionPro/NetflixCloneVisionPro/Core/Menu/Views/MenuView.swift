//
//  MenuView.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 23.06.2023.
//

import SwiftUI

struct MenuView: View {
    @Binding var selectedMenu: EMenu
    @State private var foregroundColor : Color = .white
    
    var body: some View {
        VStack(alignment: .leading){
            Image("img-netflix-logo-word")
                .resizable()
                .scaledToFit()
                .frame(height: 45)
                .tint(.white)
                .shadow(color: .black.opacity(0.29), radius: 2,x: 2,y: 1)
                .padding(.leading, 29)
                .padding(.bottom, 14)
            
            HStack(alignment: .top, spacing: 0){
                
                    Image(systemName: "arrowtriangle.right.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .foregroundStyle(.white)
                        .frame(width: 25, height: 25)
                        .padding(.vertical,7)
                        .offset(x: -14, y: (CGFloat(selectedMenu.id) * 56.0))
                
                
                
                VStack(alignment: .leading){
                    ForEach(EMenu.allCases, id: \.id){menu in
                        MenuBarItemView(menu: menu, selectedMenu: $selectedMenu)
                        
                    }
                }
            }
            .shadow(color: .black, radius: 2, x: 0, y: 2)
            
        }
    }
}

#Preview {
    MenuView(selectedMenu: .constant(.home))
}
