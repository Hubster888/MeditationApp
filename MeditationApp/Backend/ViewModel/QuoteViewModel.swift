//
//  QuoteViewModel.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 15/04/2021.
//

import Foundation

class QuoteViewModel {
    let quoteList : [Quote] = [
        Quote(quote: "“Feelings come and go like clouds in a windy sky. Conscious breathing is my anchor.”", author: "Thich Nhat Hahn"),
        Quote(quote: "“Give the child a taste of meditation by creating a climate and atmosphere of love, acceptance and silence.”", author: "Swami Dhyan Giten")
    ]
    
    func pickRandomQuote() -> Quote{
        let index = Int.random(in: 0..<quoteList.count)
        return quoteList[index]
    }
}
