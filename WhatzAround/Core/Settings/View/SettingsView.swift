//
//  SwiftUIView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 06/05/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView {
                        VStack(alignment: .leading) {
                           
                            
                            SettingsListView(width: proxy.size.width - 30)
                            Spacer()
                                .frame(height: 10)
                            }
                        
                        }
                }
                .scrollIndicators(.hidden)
                .background(Color(.systemGray6))
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                       Text("Setting")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(spacing: 24) {
                            Image(systemName: "gearshape.gear")
                            
                                
                        }
                        .fontWeight(.bold)
                        
                    }
            }
        }
    }
}



struct SettingsListView: View {
    private var width: CGFloat
    @State private var showAlert: Bool = false
    @StateObject private var viewModel = SettingsViewModel()
    init(width: CGFloat) {
        self.width = width
    }
    var body: some View {
        VStack {
            
            NavigationLink {
                SetLocationView()
                    
            } label: {
                Text("Set My Location")
                    .font(.headline)
                    .frame(width: width, height: 44)
                    .background(Color(.systemGray4))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(.black)
                    .padding()
            }
        
            
            
            Button(action: {
                showAlert.toggle()
            }, label: {
                Text("Log Out")
                    .font(.headline)
                    .frame(width: width, height: 44)
                    .background(Color(.systemGray4))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(.black)
                    .padding()
            })
            .alert("Log out of your account?", isPresented: $showAlert, actions: {
                Button("Logout") {
                    viewModel.logout()
                }
                Button("Cancel", role: .cancel) {}
            })
        }
    }
}
