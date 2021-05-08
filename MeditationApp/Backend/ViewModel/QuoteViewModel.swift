//
//  QuoteViewModel.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 15/04/2021.
//

import Foundation

class QuoteViewModel {
    let quoteList : [Quote] = [
        Quote(quote: "“Quiet the mind, and the soul will speak.”", author: "Ma Jaya Sati Bhagavati"),
        Quote(quote: "“Learn to be calm and you will always be happy.”", author: "Paramahansa Yogananda"),
        Quote(quote: "“Calmness of mind is one of the beautiful jewels of wisdom.”", author: "James Allen"),
        Quote(quote: "“When meditation is mastered, the mind is unwavering like the flame of a candle in a windless place.”", author: "Bhagavad Gita"),
        Quote(quote: "“Nowhere can man find a quieter or more untroubled retreat than in his own soul.”", author: "Marcus Aurelius"),
        Quote(quote: "“Your calm mind is the ultimate weapon against your challenges. So relax.”", author: "Bryant McGill"),
        Quote(quote: "“When you realize there is nothing lacking, the whole world belongs to you.”", author: "Lao Tzu"),
        Quote(quote: "“Meditation is not evasion; it is a serene encounter with reality.”", author: "Thich Nhat Hanh"),
        Quote(quote: "“The best meditation is effortless. The best meditation is a gentle awareness.”", author: "Maxime Lagacé"),
        Quote(quote: "“Do not dwell in the past, do not dream of the future, concentrate the mind on the present moment.”", author: "Buddha"),
        Quote(quote: "“Meditation is the art of doing nothing.”", author: "Naval Ravikant"),
        Quote(quote: "“Praying is talking to the Universe. Meditation is listening to it.”", author: "Paulo Coelho"),
        Quote(quote: "“You must find the place inside yourself where nothing is impossible.”", author: "Deepak Chopra"),
        Quote(quote: "“Be here now. Be someplace else later. Is that so complicated?”", author: "David M. Bader"),
        Quote(quote: "“Live the actual moment. Only this actual moment is life.”", author: "Thich Nhat Hanh"),
        Quote(quote: "“Wisdom comes with the ability to be still. Just look and listen. No more is needed.”", author: "Eckhart Tolle"),
        Quote(quote: "“Don’t seek, don’t search, don’t ask, don’t knock, don’t demand – relax.”", author: "Osho"),
        Quote(quote: "“A quiet mind is more important than a positive mind.”", author: "Deepak Chopra"),
        Quote(quote: "“When we are unable to find tranquility within ourselves, it is useless to seek it elsewhere.”", author: "Francois de La Rochefoucauld"),
        Quote(quote: "“To be concentrated means to live fully in the present.”", author: "Erich Fromm"),
        Quote(quote: "“Paradise is not a place, it’s a state of consciousness.”", author: "Sri Chinmoy"),
        Quote(quote: "“Meditation is all about connecting with your soul.”", author: "Deepak Chopra")
    ]
    
    func pickRandomQuote() -> Quote{
        let index = Int.random(in: 0..<quoteList.count)
        return quoteList[index]
    }
}
