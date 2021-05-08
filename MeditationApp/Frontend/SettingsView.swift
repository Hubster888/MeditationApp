//
//  SettingsView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 30/03/2021.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    @EnvironmentObject var settings : SettingsViewModel
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @State private var displayIndex = 0
    @State private var signedIn : Bool = false
    @State private var loginDisplayed : Bool = false
    var displayOptions = ["Light", "Adaptive", "Dark"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("MEDITATION")){
                    Picker(selection: $displayIndex, label: Text("Display Mode")) {
                        ForEach(0 ..< displayOptions.count) {
                            Text(self.displayOptions[$0])
                        }
                    }.disabled(true)
                    Button(action: {
                        currentUser.resetStats()
                    }){
                        Text("Reset Stats")
                    }
                }
                Section(header: Text("ACCOUNT")){
                    Button(action: {
                        if(signedIn){
                            currentUser.signOut()
                        }else{
                            self.loginDisplayed = true
                        }
                    }){
                        Text(signedIn ? "Sign Out" : "Sign In")
                    }
                    Button(action: {
                        
                    }){
                        Text("Get Premium")
                    }.disabled(true)
                }
            }
            .navigationBarTitle(Text("Settings"))
            .onAppear(){
                Auth.auth().addStateDidChangeListener { (auth, user) in
                  // Make the changes when the user is logged in or out
                    if(auth.currentUser != nil){
                        self.signedIn = true
                    }else{
                        self.signedIn = false
                    }
                }
            }
            .sheet(isPresented: $loginDisplayed) {
                LogInView().environmentObject(self.currentUser)
            }
        }
    }
}
