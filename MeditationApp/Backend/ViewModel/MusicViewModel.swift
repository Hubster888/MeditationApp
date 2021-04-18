//
//  MusicViewModel.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 08/04/2021.
//

import Foundation

class MusicViewModel : ObservableObject {
    @Published var musicList : [Music] = [
        Music(name: "music1"),
        Music(name: "music2"),
        Music(name: "music3"),
        Music(name: "music4"),
        Music(name: "music5")
    ]
    @Published var chosenMusic : Music = Music(name: "music1")
}
