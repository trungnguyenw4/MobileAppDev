//
//  RootView.swift
//  What'sNews
//
//  Created by Trung Nguyen on 06/05/2024.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = RootViewModel()
    @EnvironmentObject var authService: AuthService
   
    
    var body: some View {
            Group {
                if viewModel.userSession != nil {
                    // User is logged in
                    if viewModel.isAnonymous {
                        // User is logged in anonymously
                        // Show restricted content for anonymous users
                        RestrictedTabbarView()
                    } else {
                        // User is logged in with email/password or other providers
                        // Show content for authenticated users
                        TabbarView()
                        
                    }
                } else {
                    // User is not logged in
                    //LoginView()
                    WelcomeView()
                }
            }
        }
    }
    



//#Preview {
//    RootView()
//}
