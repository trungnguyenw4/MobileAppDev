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
            JokeView()
                .tabItem {
                    VStack{
                        Image(systemName: "eyes.inverse")
                            .environment(\.symbolVariants, selectedTab  == 1 ? . fill: .none )
                        Text("JK")
                        
                    }
                    .onAppear{selectedTab = 1}
                    
                }
        
            
            
            LinkAccountView()
                .tabItem {
                    VStack{
                        Image(systemName: "gear.circle.fill")
                            .environment(\.symbolVariants, selectedTab  ==  2 ? . fill: .none )
                        Text("Link Account")
                        
                    }
                    .onAppear{selectedTab = 2}
                    
                }
            
        }
        .tint(.black)
    }
}




#Preview {
    RestrictedTabbarView()
}
