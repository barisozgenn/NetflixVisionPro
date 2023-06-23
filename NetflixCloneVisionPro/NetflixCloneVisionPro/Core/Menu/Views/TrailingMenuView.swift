//
//  TrailingMenuView.swift
//  NetflixVisionPro
//
//  Created by Baris OZGEN on 23.06.2023.
//

import SwiftUI

struct TrailingMenuView: View {
    @State private var foregroundColor : Color = .white
    @State private var isSearchActive = false
    @Binding var searchText: String
    
    var body: some View {
        HStack(alignment: .top){
            Spacer()
            searchView
            Text("Kids")
                .font(.system(size: 25))
                .fontWeight(.semibold)
                .padding(.trailing)
            Image(systemName: "bell")
                .resizable()
                .scaledToFit()
                .frame(height: 32)
                .tint(.white)
            HStack{
                Image("default-profile-baris")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 36)
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
            .padding(.trailing,7)
        }
    }
    private var searchView: some View{
        HStack(alignment: .top){
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(height: 32)
                .tint(.white)
                .padding(.all, 4)
                .onTapGesture {
                    withAnimation(.spring()){
                        isSearchActive.toggle()
                    }
                }
            ZStack(alignment: .centerFirstTextBaseline){
                if searchText.isEmpty {
                    Text("Titles, people")
                        .foregroundStyle(.white.opacity(0.729))
                        .font(.system(size: 25))
                        .frame(width: isSearchActive ? 229 : 0, alignment: .leading)
                        .scaleEffect(x: isSearchActive ? 1 : 0)
                        .opacity(isSearchActive ? 1 : 0)
                }
                TextField("", text: $searchText)
                    .frame(width: isSearchActive ? 229 : 0)
                    .scaleEffect(x: isSearchActive ? 1 : 0)
                    .textFieldStyle(.plain)
                    .foregroundStyle(.white)
                    .font(.system(size: 25))
                    .padding(.all,4)
            }
            
        }
        .padding(.all, 4)
        .overlay {
            if isSearchActive {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.white, lineWidth: 1)
            }
        }
        .offset(y: -8)
    }
}

#Preview {
    TrailingMenuView(searchText: .constant(""))
}
