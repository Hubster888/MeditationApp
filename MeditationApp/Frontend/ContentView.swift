//
//  ContentView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 24/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Variable declerations
    // Related data variables
    @ObservedObject var currentUser : CurrentUserViewModel = CurrentUserViewModel()
    @ObservedObject var settings : SettingsViewModel = SettingsViewModel()
    @ObservedObject var musciViewModel : MusicViewModel = MusicViewModel()
    @ObservedObject var homeViewModel : HomeViewModel = HomeViewModel()
    
    // Navigation variables
    @State var settingsIsOpen : Bool = false
    @State var quote : Quote = Quote(quote: "“Give the child a taste of meditation by creating a climate and atmosphere of love, acceptance and silence.”", author: "Swami Dhyan Giten")
    
    // View variables
    var listPadding : CGFloat {
        return height * 0.025
    }
    var centerPaddingBottom : CGFloat {
        return height * 0.2
    }
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    @State var animation : Bool = false
    
    //MARK: Body
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                //Music List
                MusicListView()
                    .environmentObject(self.musciViewModel)
                    .environmentObject(self.homeViewModel)
                    .ignoresSafeArea(.all)
                    .padding(.bottom, height * 0.02)
                    .padding(.top, 20)
                //Quote
                Text("Quote by \(quote.author)")
                    .font(.title3)
                    .foregroundColor(Color(ColorConfig().getdarkTextColor()))
                    .bold()
                    .padding(.bottom, 5)
                    .onAppear(){
                        quote = QuoteViewModel().pickRandomQuote()
                    }
                Text(quote.quote)
                    .font(.title3)
                    .foregroundColor(Color(ColorConfig().getdarkTextColor()))
                    .frame(width: width * 0.75)
                    .multilineTextAlignment(.center)
                    //.padding(.bottom, height * 0.015)
                //Image and button
                CenterView()
                    .environmentObject(self.musciViewModel)
                    .environmentObject(self.currentUser)
                    .padding(.bottom, centerPaddingBottom)
                    //.offset(y: -height * 0.09)
                Spacer()
            }
            
            //Menu Button with absolut position
            MenuButtonView()
                .environmentObject(self.homeViewModel)
                .offset(x: width * 0.45, y: height * 0.45)
            
            //Menu Overlay
            VStack{
                Spacer()
                Button(action: {
                    self.settingsIsOpen = true
                }){
                    SettingsButton()
                        .animation(.spring())
                        .scaleEffect(homeViewModel.menuIsActive ? 1 : 0)
                }
                .buttonStyle(ScaleAnimationButtonEffect())
                .sheet(isPresented: $settingsIsOpen) {
                    SettingsView()
                        .environmentObject(self.settings)
                        .environmentObject(self.currentUser)
                }
                .padding(.bottom, height * 0.05)
                .padding(.top, height * 0.15)
                .allowsHitTesting(homeViewModel.menuIsActive ? true : false)
                StatsTableView()
                    .environmentObject(self.currentUser)
                    .scaleEffect(homeViewModel.menuIsActive ? 1 : 0)
                    .padding(.bottom, height * 0.05)
                    .allowsHitTesting(homeViewModel.menuIsActive ? true : false)
                AchivementsTableView()
                    .padding(.bottom, height * 0.25)
                    .scaleEffect(homeViewModel.menuIsActive ? 1 : 0)
                    .allowsHitTesting(homeViewModel.menuIsActive ? true : false)
                Spacer()
            }.scaleEffect(height < 750 ? 0.9 : 1)
        }.background(
            Image("background")
                .resizable()
                .scaledToFill()
                .blur(radius: 5)
                .opacity(0.4)
                .ignoresSafeArea(.all)
        )
    }
}

