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
    var imageSize : CGFloat {
        return height < 800 ? width * 0.45 : width * 0.7
    }
    var offsets : CGFloat {
        height < 800 ? -15 : 0
    }
    
    var body: some View {
        ZStack{
            Color(ColorConfig().getDefaultMainColor()).ignoresSafeArea()
            VStack{
                if(height > 800){
                    Text("Join The Zen!")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(ColorConfig().getLightTextColor()))
                        .padding(.bottom, height * 0.02)
                        .offset(y: offsets)
                    Spacer()
                }
                AnimatedImageView(fileName: "meditationGIF")
                    .scaledToFit()
                    .mask(Circle())
                    .shadow(radius: 15)
                    .overlay(Circle().stroke(Color(ColorConfig().getDefaultBackColor()), lineWidth: 5).shadow(radius: 15))
                    .frame(width: imageSize, height: imageSize, alignment: .center)
                    .padding(.bottom, height * 0.025)
                    .offset(y: offsets)
                TextField("Email", text: $userViewModel.email)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(ColorConfig().getLightTextColor()))
                    .cornerRadius(5.0)
                    .padding()
                    .frame(width: width * 0.85)
                    .offset(y: offsets)
                SecureField("Password", text: $userViewModel.password)
                    .padding()
                    .background(Color(ColorConfig().getLightTextColor()))
                    .cornerRadius(5.0)
                    .padding()
                    .frame(width: width * 0.85)
                    .offset(y: offsets)
                SecureField("Confirm Password", text: $userViewModel.passwordAgain)
                    .padding()
                    .background(Color(ColorConfig().getLightTextColor()))
                    .cornerRadius(5.0)
                    .padding()
                    .frame(width: width * 0.85)
                    .padding(.bottom, height * 0.025)
                    .offset(y: offsets)
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
                .offset(y: offsets)
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
