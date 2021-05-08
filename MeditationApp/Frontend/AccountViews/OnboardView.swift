//
//  OnboardView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 20/04/2021.
//

import SwiftUI
import Firebase

struct OnboardView: View {
    private let onBoardData : [OnboardingDataModel] = [
            OnboardingDataModel(image: "music1", heading: "Whats the point?", text: "This app provides you with what you need to make your meditation better without overwhelming you with pointless content."),
            OnboardingDataModel(image: "music2", heading: "The Zen", text: "Zen points are collected whenever you meditate and are used to unlock new music and sounds!"),
            OnboardingDataModel(image: "music3", heading: "Why?", text: "We provide anything you need for free to allow you to focus on whats important while helping you stay consistent.")
        ]
    @State var stateChange : Bool = true
    @State var showingLogIn = false
    @State private var goToMainView : Bool = false
    @State private var isShowingDetailView = false
    @State private var onboardFinished = false
    @State private var showingAsk : Bool = false
    @ObservedObject var currentUser : CurrentUserViewModel = CurrentUserViewModel()
    @EnvironmentObject var settings : SettingsViewModel
    @EnvironmentObject var musciViewModel : MusicViewModel
    @EnvironmentObject var homeViewModel : HomeViewModel
        
    var body: some View {
        ZStack{
            Color(ColorConfig().getDefaultMainColor())
                .ignoresSafeArea(.all)
            OnboardingViewPure(data: onBoardData, doneFunction: {
                self.onboardFinished = true
                UserDefaults.standard.set(true, forKey: "launchedBefore")
                self.showingAsk = true
                /*if(Auth.auth().currentUser != nil){
                    self.isShowingDetailView = true
                }else{
                    self.showingLogIn = true
                }*/
            }, backgroundColor: Color(ColorConfig().getDefaultMainColor()))
            .sheet(isPresented: $showingLogIn) {
                LogInView().environmentObject(self.currentUser)
            }
            .navigate(to: ContentView()
                        .environmentObject(self.currentUser)
                        .environmentObject(self.settings)
                        .environmentObject(self.musciViewModel)
                        .environmentObject(self.homeViewModel)
                      , when: $isShowingDetailView)
            .onAppear(){
                Auth.auth().addStateDidChangeListener { (auth, user) in
                  // Make the changes when the user is logged in or out
                    if Auth.auth().currentUser != nil && self.onboardFinished{
                        self.isShowingDetailView = true
                    }
                }
            }
            .alert(isPresented: $showingAsk) {
                Alert(
                    title: Text("Log In?"),
                    primaryButton: .default(Text("Log In")) {
                        showingLogIn = true
                    },
                    secondaryButton: .default(Text("Skip"), action: {
                        self.isShowingDetailView = true
                    })
                )
            }
        }
    }
}

extension View {

    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
    }
}
