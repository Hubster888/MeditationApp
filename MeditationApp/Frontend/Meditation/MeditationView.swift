//
//  MeditationView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 07/04/2021.
//

import SwiftUI
import AVFoundation

struct MeditationView: View {
    @State var audioPlayer : AVAudioPlayer?
    @State var isMoving : Bool = false
    var imageAnimationOffset : CGFloat {
        return width
    }
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var meditationViewModel : MeditationViewModel = MeditationViewModel()
    @EnvironmentObject var currentUser : CurrentUserViewModel
    let musicName : String
    @State var isTimerRunning = false
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                TimerView()
                    .environmentObject(self.meditationViewModel)
                    .environmentObject(self.currentUser)
                    .padding(.bottom, 50)
                VStack{
                    Button(action: {
                        if let path = Bundle.main.path(forResource: "music1", ofType: ".mp3") { // Change "music1" to musicName when songs downloaded
                            UIApplication.shared.isIdleTimerDisabled.toggle()
                            self.audioPlayer = AVAudioPlayer()

                            withAnimation{
                                meditationViewModel.timerIsRunning.toggle()
                            }

                            let url = URL(fileURLWithPath: path)

                            do {
                                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                                self.audioPlayer?.numberOfLoops = -1
                                self.audioPlayer?.prepareToPlay()
                                if(meditationViewModel.timerIsRunning){
                                    self.audioPlayer?.play()
                                }
                            }catch {
                                print("Error")
                            }
                        }
                        meditationViewModel.timeLeft = secondsToHoursMinutesSeconds(seconds: meditationViewModel.timeSelected).1 * 60
                    }){
                        ControlButtonView(type: .playPause)
                            .environmentObject(self.meditationViewModel)
                    }
                    .buttonStyle(ScaleAnimationButtonEffect())
                    .padding(.bottom, height * 0.05)
                    
                    Button(action: {
                        if(meditationViewModel.timeLeft > 3300){
                            currentUser.updateTotalSessions()
                        }
                        presentationMode.wrappedValue.dismiss()
                    }){
                        ControlButtonView(type: .end)
                            .environmentObject(self.meditationViewModel)
                    }.buttonStyle(ScaleAnimationButtonEffect())
                }
                .padding(.bottom, height * 0.05)
                Spacer()
            }.background(
                Image(musicName)
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 5)
                    .ignoresSafeArea(.all)
                    .offset(x: isMoving ? -imageAnimationOffset : imageAnimationOffset)
                    .animation(Animation.linear(duration: 18).repeatForever())
                    .onAppear(){
                        isMoving = true // While developing leave this on FALSE
                    }
            )
            EndView(numOfPoints: secondsToHoursMinutesSeconds(seconds: meditationViewModel.timeSelected).1)
                .environmentObject(self.currentUser)
                .scaleEffect(meditationViewModel.isFinished ? 1 : 0)
                .allowsHitTesting(meditationViewModel.isFinished ? true : false)
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
