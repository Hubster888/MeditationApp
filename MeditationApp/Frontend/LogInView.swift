//
//  LogInView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 20/04/2021.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var userViewModel : CurrentUserViewModel

    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            Text("Welcome")
            Image("music1")
                .resizable()
                .scaledToFit()
                .animation(Animation.linear(duration: 8).repeatForever())
                .mask(Circle())
                .shadow(radius: 15)
                .overlay(Circle().stroke(Color(ColorConfig().getDefaultBackColor()), lineWidth: 5).shadow(radius: 15))
                .frame(width: width, height: width, alignment: .center)
            TextField("Email", text: $userViewModel.email)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $userViewModel.password)
                .padding()
                .background(Color.gray)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            Button(action: {
                userViewModel.login()
            }) {
                Text("Sign up")
            }.disabled(!userViewModel.isValid)
        }
    }
}

