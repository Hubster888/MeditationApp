//
//  CurrentUserViewModel.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 15/04/2021.
//

import Foundation
import Combine
import Firebase

class CurrentUserViewModel : ObservableObject{
    @Published var currentUser : CurrentUser
    
    let defaults = UserDefaults.standard
    
    //MARK: Login fields and checks
    // Input to login screen
    @Published var email = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    // Output to login screen
    @Published var isValid = false
    private var cancellableSet = Set<AnyCancellable>()
    
    init(){
        let currentStreak = defaults.integer(forKey: "streak")
        let currentZen = defaults.integer(forKey: "points")
        let totalSessions = defaults.integer(forKey: "totalSessions")
        self.currentUser = CurrentUser(currentStreak: currentStreak, currentZenPoints: currentZen, totalSessions: totalSessions)
        
        isDetailsValid
              .receive(on: RunLoop.main)
              .assign(to: \.isValid, on: self)
              .store(in: &cancellableSet)
    }
    
    private var isDetailsValid: AnyPublisher<Bool, Never> {
      Publishers.CombineLatest(isEmailValid, isPasswordEmptyPublisher)
        .map { emailIsValid, passwordIsEmpty in
            return emailIsValid && !passwordIsEmpty
        }
        .eraseToAnyPublisher()
    }
    
    private var isEmailValid: AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { email in
                return email.count >= 3
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { password in
            return password == ""
          }
          .eraseToAnyPublisher()
      }
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
          // Do stuff after sign in?
        }
    }

    //MARK: User stats
    func updateStreak(){
        let lastDateMeditated : Date = defaults.object(forKey: "lastDate") as! Date
        let nextDayDate : Date = Date().addingTimeInterval(86400)
        let isAdd = Calendar.current.isDate(lastDateMeditated, equalTo: nextDayDate, toGranularity: .day)
        if(!isAdd){
            let currentStreak = defaults.integer(forKey: "streak")
            if(currentStreak > 5){
                updateZenPoints(isAdd: false, numOfPoints: currentStreak)
            }
            defaults.set(0 , forKey: "streak")
            currentUser.currentStreak = 0
        }else{
            var currentStreak = defaults.integer(forKey: "streak")
            currentStreak += 1
            defaults.set(currentStreak, forKey: "streak")
            defaults.set(Date(), forKey: "lastDate")
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
        defaults.set(false, forKey: "launchedBefore") // Remove after dev
        currentUser.currentStreak = 0
        currentUser.currentZenPoints =  0
        currentUser.totalSessions = 0
    }
}

/*
 Number of Zen point:
 -- Point per minute of meditation
 Straks:
 -- 3 days = 1.5x
 -- 5 days = 2x
 -- 15 days = 3x
 -- 30 days = 4x
 -- 100 days = 5x
 User looses points when loosing a biger streak
 */
