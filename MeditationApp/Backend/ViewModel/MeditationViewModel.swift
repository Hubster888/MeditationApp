//
//  MeditationViewModel.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 12/04/2021.
//

import Foundation
import AVFoundation

class MeditationViewModel : ObservableObject {
    @Published var timerIsRunning : Bool = false
    @Published var timeLeft : Int = 5 // 60
    @Published var timeSelected : Int = 5 // 120
    @Published var isFinished : Bool = false
    
    var audioPlayer: AVAudioPlayer?
    
    func finishMeditation(){
        if(timerIsRunning && timeLeft == 0){
            isFinished = true
            playSound()
        }
    }
    
    func playSound() {
        if let path = Bundle.main.path(forResource: "endMedSound", ofType: ".wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.setVolume(0.25, fadeDuration: 2)
                audioPlayer?.play()
            } catch {
                print("ERROR")
            }
        }
    }
}
