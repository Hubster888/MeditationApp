//
//  SettingsView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 30/03/2021.
//

import SwiftUI
import Firebase
import UserNotifications

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
                    Button(action: {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                let content = UNMutableNotificationContent()
                                content.title = "Dont forget to get your zen!"
                                content.subtitle = "You will loose your streak if you dont meditate daily."
                                content.sound = UNNotificationSound.default

                                // show this notification five seconds from now
                                var dateComponents = DateComponents()
                                dateComponents.hour = 9
                                dateComponents.minute = 30
                                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                                
                                // choose a random identifier
                                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                                // add our notification request
                                UNUserNotificationCenter.current().add(request)
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }){
                        Text("Allow notifications")
                    }
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
