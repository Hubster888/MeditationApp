//
//  SignUpView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 22/04/2021.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var userViewModel : CurrentUserViewModel
    @Environment(\.presentationMode) var presentationMode
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            Color(ColorConfig().getDefaultMainColor()).ignoresSafeArea()
            VStack{
                Text("Join The Zen!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(ColorConfig().getLightTextColor()))
                    .padding(.bottom, height * 0.02)
                Spacer()
                AnimatedImageView(fileName: "meditationGIF")
                    .scaledToFit()
                    .mask(Circle())
                    .shadow(radius: 15)
                    .overlay(Circle().stroke(Color(ColorConfig().getDefaultBackColor()), lineWidth: 5).shadow(radius: 15))
                    .frame(width: width * 0.7, height: width * 0.7, alignment: .center)
                    .padding(.bottom, height * 0.025)
                TextField("Email", text: $userViewModel.email)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(ColorConfig().getLightTextColor()))
                    .cornerRadius(5.0)
                    .padding()
                    .frame(width: width * 0.85)
                SecureField("Password", text: $userViewModel.password)
                    .padding()
                    .background(Color(ColorConfig().getLightTextColor()))
                    .cornerRadius(5.0)
                    .padding()
                    .frame(width: width * 0.85)
                SecureField("Confirm Password", text: $userViewModel.passwordAgain)
                    .padding()
                    .background(Color(ColorConfig().getLightTextColor()))
                    .cornerRadius(5.0)
                    .padding()
                    .frame(width: width * 0.85)
                    .padding(.bottom, height * 0.025)
                Button(action: {
                    userViewModel.signUp()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Sign Up")
                        .font(.title)
                        .bold()
                        .foregroundColor(
                            !userViewModel.signupIsValid ?
                                Color(ColorConfig().getdarkTextColor()).opacity(0.4) : Color(ColorConfig().getLightTextColor()))
                        .background(
                            Rectangle().fill(!userViewModel.signupIsValid ? Color(ColorConfig().getDefaultBackColor()) : Color(ColorConfig().getStartColor()))
                                .frame(width: 160, height: 50, alignment: .center)
                                .blur(radius: 3)
                                .cornerRadius(15)
                    )
                }
                .disabled(!userViewModel.signupIsValid)
                .padding(.bottom, height * 0.05)
                Spacer()
            }.background(Color(ColorConfig().getDefaultMainColor()))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(CurrentUserViewModel())
    }
}
