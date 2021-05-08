//
//  LogInView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 20/04/2021.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var userViewModel : CurrentUserViewModel
    @Environment(\.presentationMode) var presentationMode

    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    var imageWidth : CGFloat {
        return height < 800 ? width * 0.8 : width
    }
    var fieldPadding : CGFloat {
        return height < 800 ? 5 : 15
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(ColorConfig().getDefaultMainColor()).ignoresSafeArea()
                VStack {
                    if(height > 800){
                        Text("Welcome Back")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(ColorConfig().getLightTextColor()))
                    }
                    Image("music1")
                        .resizable()
                        .scaledToFit()
                        .mask(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color(ColorConfig().getDefaultBackColor()), lineWidth: 5).shadow(radius: 10))
                        .frame(width: imageWidth, height: imageWidth, alignment: .center)
                        .offset(y: -50)
                    TextField("Email", text: $userViewModel.email)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(ColorConfig().getLightTextColor()))
                        .cornerRadius(5.0)
                        .padding()
                        .frame(width: width * 0.85)
                        .padding(.bottom, fieldPadding)
                        .offset(y: height < 800 ? -80 : -60)
                    SecureField("Password", text: $userViewModel.password)
                        .padding()
                        .background(Color(ColorConfig().getLightTextColor()))
                        .cornerRadius(5.0)
                        .padding()
                        .frame(width: width * 0.85)
                        .padding(.bottom, fieldPadding)
                        .offset(y: height < 800 ? -90 : -70)
                    Button(action: {
                        userViewModel.login()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Log In")
                            .font(.title)
                            .bold()
                            .foregroundColor(
                                !userViewModel.isValid ?
                                    Color(ColorConfig().getdarkTextColor()).opacity(0.4) : Color(ColorConfig().getLightTextColor()))
                            .background(
                                Rectangle().fill(!userViewModel.isValid ? Color(ColorConfig().getDefaultBackColor()) : Color(ColorConfig().getStartColor()))
                                    .frame(width: 160, height: 50, alignment: .center)
                                    .blur(radius: 3)
                                    .cornerRadius(15)
                        )
                    }
                    .disabled(!userViewModel.isValid)
                    .padding(.bottom, 35)
                    .offset(y: height < 800 ? -80 : -60)
                    Spacer()
                    NavigationLink(destination: SignUpView().environmentObject(self.userViewModel)){
                        Text("New To Zen?")
                            .font(.title)
                            .bold()
                            .foregroundColor(
                                    Color(ColorConfig().getDefaultBackColor()))
                            .background(
                                Rectangle().fill(Color(ColorConfig().getDefaultMainColor()))
                                    .frame(width: 160, height: 50, alignment: .center)
                                    .blur(radius: 3)
                                    .cornerRadius(15)
                        )
                    }.padding(.bottom, height * 0.05)
                    .offset(y: height < 800 ? -60 :-40)
                    Spacer()
                }
            }
        }.accentColor(Color(ColorConfig().getLightTextColor()))
    }
}

