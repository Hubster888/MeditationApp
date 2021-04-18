//
//  TimerView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 11/04/2021.
//

import SwiftUI

struct TimerView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    @EnvironmentObject var meditationViewModel : MeditationViewModel
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @State private var value: Double = 0

    var body: some View {
        VStack{
            ZStack{
                Blur(effect: UIBlurEffect(style: .light))
                    .clipShape(Circle())
                    .frame(width: width * 0.75, height: width * 0.75, alignment: .center)
                    .opacity(!meditationViewModel.timerIsRunning ? 0 : 1)
                Text(meditationViewModel.timeLeft > 3300 ? "unlimited" : String(format: "%02d:%02d", secondsToHoursMinutesSeconds(seconds: meditationViewModel.timeLeft).1, secondsToHoursMinutesSeconds(seconds: meditationViewModel.timeLeft).2))
                    .font(.system(size: width * 0.125))
                    .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                    .bold()
                    .onReceive(timer) { time in
                        if self.meditationViewModel.timerIsRunning {
                            if self.meditationViewModel.timeLeft > 0 && self.meditationViewModel.timeLeft < 3300{
                                self.meditationViewModel.timeLeft -= 1
                            }else if(self.meditationViewModel.timeLeft == 0){
                                withAnimation(){
                                    meditationViewModel.finishMeditation()
                                }
                            }
                        }
                    }
                    .opacity(!meditationViewModel.timerIsRunning ? 0 : 1)
                TimePickerView().opacity(meditationViewModel.timerIsRunning ? 0 : 1)
            }.scaleEffect(0.8)
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}


struct Blur: UIViewRepresentable {
    var effect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }

}
