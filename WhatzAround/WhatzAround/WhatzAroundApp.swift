//
//  WhatzAroundApp.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 06/05/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct WhatzAroundSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var newsViewModel = NewsViewModel()
    @StateObject var jokeViewModel = JokeViewModel()
    @StateObject var mapViewModel = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
           RootView()
                .environmentObject(jokeViewModel)
                .environmentObject(mapViewModel)
                .environmentObject(newsViewModel)
               
        }
    }
}
