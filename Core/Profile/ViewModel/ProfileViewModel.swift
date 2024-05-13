//
//  ProfileViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 06/05/2024.
//

import Foundation

import SwiftUI
import Firebase
import Combine


class ProfileViewModel: ObservableObject {
    
//    @Published var selectedImage: PhotosPickerItem? {
//                didSet { Task {try await loadImage(fromItem: selectedImage)} }
//            }
//    @Published var profileImage: Image = Image("no_profile")
//    private var uiImage: UIImage?
//    
//    private func loadImage(fromItem item: PhotosPickerItem?) async throws{
//                guard let item = item else { return }
//                guard let data = try? await item.loadTransferable(type: Data.self) else { return }
//                guard let uiImage = UIImage(data: data) else { return }
//                self.uiImage = uiImage
//                self.profileImage = Image(uiImage: uiImage)
//                try await updateProfileImage()
//        }
//    
//    private func updateProfileImage() async throws {
//                guard let image = self.uiImage else { return }
//                guard let imageUrl = try? await ImageUploader.uploadImage(image) else { return }
//                try await UserService.shared.updateUserProfileImage(withImageUrl: imageUrl)
                
        }
    



