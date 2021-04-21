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
            OnboardingDataModel(image: "music1", heading: "What's the plan?", text: "This here is your personalised skating plan to improve those skills in your own time. Based on a few answers you will provide; the plan plops you into the correct week and adjusts the time spent skating to your free time."),
            OnboardingDataModel(image: "music2", heading: "Why?", text: "Don’t know what you're doing? The plan lets you improve on your own terms and guides you through the stages of becoming a “good” skater and enjoying yourself more. \"The plan only shows recommendations, you need to go at your own pace!\""),
            OnboardingDataModel(image: "music3", heading: "How to?", text: "If you feel you struggled during a week, do the week over again. The whole point is to enjoy yourself. Do whatever you enjoy. Don’t be sacred to try new skills, often after a few tries of a new trick you will gain confidence even though you may have not landed it yet.")
        ] //TODO: Write meaningful onboarding and find the pics
    @State var showingLogIn = false
    @State private var goToMainView : Bool = false
    @State private var isShowingDetailView = false
        
    var body: some View {
        ZStack{
            Color(ColorConfig().getDefaultMainColor()).ignoresSafeArea(.all)
            OnboardingViewPure(data: onBoardData, doneFunction: {
                if(Auth.auth().currentUser != nil){
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                    self.isShowingDetailView = true
                }else{
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                    self.showingLogIn = true
                }
            }, backgroundColor: Color(ColorConfig().getDefaultMainColor()))
            .sheet(isPresented: $showingLogIn) {
                LogInView()
            }
            .navigate(to: ContentView(), when: $isShowingDetailView)
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
