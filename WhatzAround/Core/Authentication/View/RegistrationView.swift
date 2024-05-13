//
//  RegistrationView.swift
//  What'sNews
//
//  Created by Trung Nguyen on 05/05/2024.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) private var dismiss
   
    

    
    
    var body: some View {
        VStack {
            Spacer()
            // logo image
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
            // textfields
            FloatingTextFieldsView(viewModel: viewModel)
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 280,height: 20)
                   
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled( viewModel.email.isEmpty || viewModel.password.isEmpty)
            .buttonStyle(BrightButtonStyle(disabled: viewModel.password.isEmpty || viewModel.email.isEmpty))
            .padding(.vertical)
            .alert("Invalid Email", isPresented: $viewModel.showInvalidEmailAlert) {
                            Button("OK", role: .cancel) {}
                        }
            .alert("Password is too weak", isPresented: $viewModel.showInvalidPasswordAlert) {
                            Button("OK", role: .cancel) {}
                        }
            Spacer()
            Divider()
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Log in")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .foregroundStyle(.gray)
            }
            .padding(.vertical)
        }
    }
}

//#Preview {
//    RegistrationView()
//}
