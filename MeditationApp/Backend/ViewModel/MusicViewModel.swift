//
//  MusicViewModel.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 08/04/2021.
//

import Foundation

class MusicViewModel : ObservableObject {
    @Published var musicList : [Music] = [
        Music(name: "music2", minZenPoints: 0),
        Music(name: "music3", minZenPoints: 0),
        Music(name: "music4", minZenPoints: 100),
        Music(name: "music5", minZenPoints: 200),
        Music(name: "music6", minZenPoints: 400),
        Music(name: "music7", minZenPoints: 500),
        Music(name: "music8", minZenPoints: 700),
        Music(name: "music9", minZenPoints: 800),
        Music(name: "music10", minZenPoints: 1000)
    ]
    @Published var chosenMusic : Music = Music(name: "music3", minZenPoints: 0)
}
