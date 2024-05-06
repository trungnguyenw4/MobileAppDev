import SwiftUI

struct TabbarView: View {
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
            
            Text ("Places")
                .tabItem {
                    VStack{
                        Image(systemName: "map.circle.fill")
                            .environment(\.symbolVariants, selectedTab  == 2 ? . fill: .none )
                        Text("Places")
                        
                    }
                    .onAppear{selectedTab = 2}
                    
                }
            
            JokeView()
                .tabItem {
                    VStack{
                        Image(systemName: "eyes.inverse")
                            .environment(\.symbolVariants, selectedTab  == 3 ? . fill: .none )
                        Text("JK")
                        
                    }
                    .onAppear{selectedTab = 3}
                    
                }
            
            SettingsView()
                .tabItem {
                    VStack{
                        Image(systemName: "gear.circle.fill")
                            .environment(\.symbolVariants, selectedTab  == 4 ? . fill: .none )
                        Text("Setting")
                        
                    }
                    .onAppear{selectedTab = 4}
                    
                }
            
        }
        .tint(.black)
    }
}


#Preview {
    TabbarView()
}
