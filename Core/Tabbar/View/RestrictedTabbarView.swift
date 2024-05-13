//
//  RestrictedTabbarView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 06/05/2024.
//

import SwiftUI

struct RestrictedTabbarView: View {
    @State private var selectedTab: Int =  0
    
    var body: some View {
        
        TabView{
            Text ("Home")
                .tabItem {
                    VStack{
                        Image(systemName: "house.fill")
                            .environment(\.symbolVariants, selectedTab  == 0 ? . fill: .none )
                        Text("Home")
                        
                    }
                    .onAppear{selectedTab = 0}
                    
                }
            
            Text ("News")
                .tabItem {
                    VStack{
                        Image(systemName: "newspaper.fill")
                            .environment(\.symbolVariants, selectedTab  == 1 ? . fill: .none )
                        Text("News")
                        
                    }
                    .onAppear{selectedTab = 1}
                    
                }
            
            
            LinkAccountView()
                .tabItem {
                    VStack{
                        Image(systemName: "gear.circle.fill")
                            .environment(\.symbolVariants, selectedTab  == 3 ? . fill: .none )
                        Text("Link Account")
                        
                    }
                    .onAppear{selectedTab = 3}
                    
                }
            
        }
        .tint(.black)
    }
}




#Preview {
    RestrictedTabbarView()
}
