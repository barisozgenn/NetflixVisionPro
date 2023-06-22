//
//  MenuView.swift
//  NetflixVisionPro
//
//  Created by Baris OZGEN on 22.06.2023.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MenuView: View {
    @Binding var selectedMenu: EMenu
    @State private var foregroundColor : Color = .white
    
    var body: some View {
        VStack(alignment: .leading){
                Image("img-netflix-logo-word")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 29)
                    .tint(.white)
                    .shadow(color: .black.opacity(0.29), radius: 2,x: 2,y: 1)
                    .padding(.leading, 29)
                    .padding(.bottom, 14)
                
            ForEach(EMenu.allCases, id: \.id){menu in
                CustomToolBarItem(menu: menu, selectedMenu: $selectedMenu)
                
            }
             
            }
    }
}
extension MenuView {
    struct CustomToolBarItem: View {
        let menu: EMenu
        @Binding var selectedMenu: EMenu
        @State private var foregroundColor : Color = .white
        var body: some View {
            HStack {
                Image(systemName: "arrowtriangle.right.fill")
                    .opacity(selectedMenu == menu ? 1 : 0)
                Text(menu.title)
                    .foregroundColor(foregroundColor)
                    .fontWeight( .bold)
                    .shadow(color: .black, radius: 3, x: 0, y: 2)
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
    }
}
/*
struct CustomToolBarTrailingView: View {
    @Binding var selectedMenuName: String
    @State private var foregroundColor : Color = .white
    @State private var isSearchActive = false
    @Binding var searchText: String

    var body: some View {
        HStack{
            Spacer()
            searchView
            MenuView.CustomToolBarItem(menuName: "Kids", selectedMenuName: $selectedMenuName)
            Image(systemName: "bell")
                .resizable()
                .scaledToFit()
                .frame(height: 18)
                .tint(.white)
            HStack{
                Image("default-profile-baris")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                    .background(.blue)
                    .cornerRadius(4)
                    .padding(.leading,14)
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 12)
                    .tint(.white)
                    .padding(.trailing,7)
            }
        }
    }
    private var searchView: some View{
        HStack{
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(height: 18)
                .tint(.white)
                .onTapGesture {
                    withAnimation(.spring()){
                        isSearchActive.toggle()
                    }
                }
            ZStack(alignment: .leading){
                if searchText.isEmpty {
                    Text("Titles, people").foregroundColor(.white)
                        .frame(width: isSearchActive ? 107 : 0, alignment: .leading)
                        .scaleEffect(x: isSearchActive ? 1 : 0)
                        .opacity(isSearchActive ? 1 : 0)
                }
                TextField("", text: $searchText)
                    .frame(width: isSearchActive ? 107 : 0)
                    .scaleEffect(x: isSearchActive ? 1 : 0)
                    .textFieldStyle(.plain)
                    .foregroundColor(.white)
            }
                
        }
        .padding(.all, 4)
        .overlay {
            if isSearchActive {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.white, lineWidth: 1)
            }
        }
    }
}
*/
#Preview {
    MenuView(selectedMenu: .constant(.home))
}
