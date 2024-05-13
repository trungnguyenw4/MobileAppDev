//
//  WelcomeView.swift
//  What'sNews
//
//  Created by Trung Nguyen on 05/05/2024.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showLoginView: Bool = false
    
    var body: some View {
        GeometryReader{proxy in
            VStack{
                HStack{
                    Spacer()
                }
                Image("familyguys")
                    .resizable()
                    .frame(width: proxy.size.width - 80 , height: proxy.size.width - 60)
                    .scaledToFill()
                VStack {
                            Text("Welcome to WhatzAround")
                        .font(.title2)
                        .fontWeight(.semibold)
                                 
                                 Text("Tap Agree and continue to accept the Terms of Service")
                                .font(.body)
                                .foregroundColor(.black)
                                .padding()
                            
                            Text("Privacy Policy")
                                .foregroundColor(.blue)
                                .underline()
                                .onTapGesture {
                                    if let url = URL(string: "https://www.termsfeed.com/live/1d2bfaab-6e54-461c-8bf6-21381b829b3b") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                                .padding(.bottom, 4) // Add some spacing between the links
                            
                            Text("Terms of Service")
                                .foregroundColor(.blue)
                                .underline()
                                .onTapGesture {
                                    if let url = URL(string: "https://www.termsfeed.com/live/ad4a7645-b187-4f02-bff9-3487985617ba") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            
                            Spacer()
                        }
                Button {
                    showLoginView.toggle()
                } label: {
                    Text("Agree and continue")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width - 80, height: 44)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                }
               
                .padding(.vertical)
            }
            .padding(.horizontal)
            .fullScreenCover(isPresented: $showLoginView) {
                LoginView()
            }
        }
    }
}

//#Preview {
//    WelcomeView()
//}
