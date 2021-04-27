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
        Achivement(name: "achivement1", image: "achivement1", isComplete: false, description: "Some description like a sentence"),
        Achivement(name: "achivement2", image: "achivement1", isComplete: false, description: "Some description like a sentence"),
        Achivement(name: "achivement3", image: "achivement1", isComplete: false, description: "Some description like a sentence"),
        Achivement(name: "achivement4", image: "achivement1", isComplete: false, description: "Some description like a sentence"),
        Achivement(name: "achivement5", image: "achivement1", isComplete: false, description: "Some description like a sentence"),
        Achivement(name: "achivement6", image: "achivement1", isComplete: false, description: "Some description like a sentence")
    ]
    
    init(){
        if(Auth.auth().currentUser != nil){
            updateAchivements()
        }
    }
    
    func updateAchivements() {
        if(Auth.auth().currentUser != nil){
            //for i in 0...achivementList.count{
                updateAchivementsFromFirebase(achivement: 1)
            //}
        }else{
            for i in 0...achivementList.count{
                //achivementList[i].isComplete = false
            }
        }
    }
    
    func updateAchivementsFromFirebase(achivement: Int){
        db.collection("users").document(Auth.auth().currentUser?.uid ?? "NO USER").getDocument() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let isComplete = querySnapshot!["a\(achivement)"] as! Bool
                self.achivementList[achivement-1].isComplete = isComplete
            }
        }
    }
}
