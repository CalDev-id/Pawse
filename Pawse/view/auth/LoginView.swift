//
//  LoginView.swift
//  Pawse
//
//  Created by hendra on 25/06/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @AppStorage("uid") var userID: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Sign In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            
            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textContentType(.emailAddress)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .textContentType(.newPassword)
            
            Button{
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    if let result = result {
                        withAnimation {
                            userID = result.user.uid
                        }
                    }
                }
            } label: {
                Text("Sign In")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.biruBTN)
                    .cornerRadius(10)
            }
            NavigationLink {
                RegisterView()
            } label: {
                Text("Sign Up here")
            }

        }
        .padding()
    }
}

#Preview {
    LoginView()
}
