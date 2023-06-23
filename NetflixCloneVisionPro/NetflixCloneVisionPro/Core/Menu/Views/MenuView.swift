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
    @State private var offsetXLogo : Double = 270
    @State private var offsetYLogo : Double = 258
    @State private var heightLogo : Double = 229
    
    var body: some View {
        VStack(alignment: .leading){
            Image("img-netflix-logo-word")
                .resizable()
                .scaledToFit()
                .frame(height: heightLogo)//45
                .tint(.white)
                .shadow(color: .black.opacity(0.29), radius: 2,x: 2,y: 1)
                .padding(.leading, 55)
                .padding(.bottom, 14)
                .offset(x: offsetXLogo, y: offsetYLogo)
                .onAppear{
                    withAnimation(.smooth.delay(1.29)){
                        offsetYLogo = 0
                        heightLogo = 45
                    }
                    withAnimation(.smooth.delay(1.92)){
                        offsetXLogo = 0
                    }
                }
            HStack(alignment: .top, spacing: 0){
                
                    Image(systemName: "arrowtriangle.right.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.thinMaterial)
                        .frame(width: 45, height: 45)
                       
                        .padding(.vertical,7)
                        .offset(x: -14, y: (CGFloat(selectedMenu.id) * 70.0))
                
                
                
                VStack(alignment: .leading){
                    ForEach(EMenu.allCases, id: \.id){menu in
                        MenuBarItemView(menu: menu, selectedMenu: $selectedMenu, animationDelay: .constant(2.29  + Double(menu.id) * 0.29))
                        
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
