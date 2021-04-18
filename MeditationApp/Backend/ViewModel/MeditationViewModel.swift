//
//  MeditationViewModel.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 12/04/2021.
//

import Foundation

class MeditationViewModel : ObservableObject {
    @Published var timerIsRunning : Bool = false
    @Published var timeLeft : Int = 5 // 60
    @Published var timeSelected : Int = 5 // 120
    @Published var isFinished : Bool = false
    
    func finishMeditation(){
        if(timerIsRunning && timeLeft == 0){
            isFinished = true
        }
    }
}
