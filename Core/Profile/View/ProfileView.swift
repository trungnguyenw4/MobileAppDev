//
//  ProfileView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 06/05/2024.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var user: User
    var body: some View {
        VStack {
            
                ZStack(alignment: .bottomTrailing) {
                    ZStack {
                        Image("no_profile")
                    }
                    .padding(.vertical)
                    Circle()
                        .fill(Color(.darkGray))
                        .frame(width: 40, height: 40)
                        .padding(.bottom,10)
                        .padding(.trailing,10)
                        .overlay {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .scaledToFill()
                                .foregroundStyle(.white)
                                .padding(.bottom,10)
                                .padding(.trailing,10)
                        }
                }
            }
            
            VStack(spacing: 32) {
                OptionView(title: "Name", subtitle: user.fullName, imageName: "person.fill",secondSubtitle: "This is not your username or pin. This name will be visible to your WhatsApp contacts.")
                OptionView(title: "About", subtitle: "Hey there! I am using WhatsApp.", imageName: "exclamationmark.circle")
                OptionView(title: "Phone", subtitle: user.phoneNumber, imageName: "phone.fill",canEdit: false)
        }
            Spacer()
         //   }
        }
        

                
    }



struct OptionView: View {
    var title: String
    var subtitle: String
    var imageName: String
    var secondSubtitle: String = ""
    var canEdit: Bool = true
    var body: some View {
        HStack(alignment: secondSubtitle != "" ? .top : .center,spacing: 24) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundStyle(.gray)
                .padding(.top,secondSubtitle != "" ? 12 : 0)
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundStyle(.gray)
                    .font(.headline)
                Text(subtitle)
                    .font(.footnote)
                if secondSubtitle != "" {
                    Text(secondSubtitle)
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.top,1)
                }
            }
            Spacer()
            if canEdit {
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.gray)
                    .padding(.top,secondSubtitle != "" ? 12 : 0)
            }
        }
        .padding(.leading)
        .padding(.trailing,16)
    }
}



#Preview {
    ProfileView(user: User.MOCK_USER)
}
