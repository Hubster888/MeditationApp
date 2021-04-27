//
//  MusicViewModel.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 08/04/2021.
//

import Foundation

class MusicViewModel : ObservableObject {
    @Published var musicList : [Music] = [
        Music(name: "music1", minZenPoints: 0),
        Music(name: "music2", minZenPoints: 0),
        Music(name: "music3", minZenPoints: 1),
        Music(name: "music4", minZenPoints: 2),
        Music(name: "music5", minZenPoints: 3)
    ]
    @Published var chosenMusic : Music = Music(name: "music2", minZenPoints: 0)
}
