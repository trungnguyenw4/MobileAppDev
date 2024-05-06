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
struct ChatAppSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var jokeViewModel = JokeViewModel()
    
    var body: some Scene {
        WindowGroup {
           RootView()
                .environmentObject(jokeViewModel)
        }
    }
}
