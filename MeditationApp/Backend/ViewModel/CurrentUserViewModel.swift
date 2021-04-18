//
//  CurrentUserViewModel.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 15/04/2021.
//

import Foundation

class CurrentUserViewModel : ObservableObject{
    @Published var currentUser : CurrentUser
    let defaults = UserDefaults.standard
    
    init(){
        let currentStreak = defaults.integer(forKey: "streak")
        let currentZen = defaults.integer(forKey: "points")
        let totalSessions = defaults.integer(forKey: "totalSessions")
        self.currentUser = CurrentUser(currentStreak: currentStreak, currentZenPoints: currentZen, totalSessions: totalSessions)
    }
    
    func updateStreak(){
        let currentDate = Date()
        let lastDateMeditated : Date = defaults.object(forKey: "lastDate") as! Date
        let isAdd = (currentDate.timeIntervalSince(lastDateMeditated) / 3600) > 24
        if(!isAdd){
            defaults.set(0 , forKey: "streak")
            currentUser.currentStreak = 0
        }else{
            var currentStreak = defaults.integer(forKey: "streak")
            currentStreak += 1
            defaults.set(currentStreak, forKey: "streak")
            currentUser.currentStreak = currentStreak
        }
    }
    
    func updateZenPoints(isAdd: Bool, numOfPoints: Int){
        if(!isAdd){
            var currentPoints = defaults.integer(forKey: "points")
            currentPoints -= numOfPoints
            defaults.set(currentPoints, forKey: "points")
            currentUser.currentZenPoints = currentPoints
        }else{
            var currentPoints = defaults.integer(forKey: "points")
            currentPoints += numOfPoints
            defaults.set(currentPoints, forKey: "points")
            currentUser.currentZenPoints = currentPoints
        }
    }
    
    func updateTotalSessions(){
        defaults.set(Date(), forKey: "lastDate")
        var currentSessions = defaults.integer(forKey: "totalSessions")
        currentSessions += 1
        defaults.set(currentSessions, forKey: "totalSessions")
        currentUser.totalSessions = currentSessions
    }
    
    func resetStats(){
        defaults.set(0, forKey: "streak")
        defaults.set(0, forKey: "points")
        defaults.set(0, forKey: "totalSessions")
        currentUser.currentStreak = 0
        currentUser.currentZenPoints =  0
        currentUser.totalSessions = 0
    }
}
