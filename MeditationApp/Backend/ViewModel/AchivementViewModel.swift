//
//  AchivementViewModel.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 25/04/2021.
//

import Foundation
import Firebase
import FirebaseFirestore

class AchivementViewModel: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var achivementList : [Achivement] = [
        Achivement(name: "Zen Starts", image: "achivement1", isComplete: false, description: "Achived once you get 250 Zen"),
        Achivement(name: "On The Journey", image: "achivement2", isComplete: false, description: "Achived when total session grows to 30"),
        Achivement(name: "Trained Mind", image: "achivement3", isComplete: false, description: "Achived when streak reaches 14")
    ]
    
    init(){
        if(Auth.auth().currentUser != nil){
            updateAchivements()
        }
    }
    
    func updateAchivements() {
        if(Auth.auth().currentUser != nil){
            for i in 0...achivementList.count - 1{
                updateAchivementsFromFirebase(achivement: i)
            }
        }else{
            for i in 0...achivementList.count - 1{
                achivementList[i].isComplete = false
            }
        }
    }
    
    func achive(achivement: Int){
        self.achivementList[achivement].isComplete = true
        db.collection("users").document(Auth.auth().currentUser?.uid ?? "NO USER").setData(
            ["a\(achivement)" : true]
        )
    }
    
    func updateAchivementsFromFirebase(achivement: Int){
        db.collection("users").document(Auth.auth().currentUser?.uid ?? "NO USER").getDocument() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let isComplete = querySnapshot!["a\(achivement + 1)"] as! Bool
                self.achivementList[achivement].isComplete = isComplete
            }
        }
    }
}
