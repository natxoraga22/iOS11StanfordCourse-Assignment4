//
//  ConcentrationGame.swift
//  iOS11StanfordCourse-Assignment1
//
//  Created by Natxo Raga Llorens on 12/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import Foundation


class ConcentrationGame {
    
    var cards = [ConcentrationCard]()
    var indexOfFaceUpCard: Int?
    var flippedIdentifiers = Set<Int>()
    var flipCount = 0
    var score = 0
    
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = ConcentrationCard()
            cards += [card, card]
        }
        // shuffle the cards
        for index in cards.indices.reversed() {
            let randomIndex = Int(arc4random_uniform(UInt32(index)))
            cards.swapAt(index, randomIndex)
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isFaceUp && !cards[index].isMatched {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    // MATCH!
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                else {
                    // MISMATCH!
                    if flippedIdentifiers.contains(cards[matchIndex].identifier) { score -= 1 }
                    if cards[index].hasBeenFaceUp { score -= 1 }
                    flippedIdentifiers.insert(cards[matchIndex].identifier)
                    flippedIdentifiers.insert(cards[index].identifier)
                }
                indexOfFaceUpCard = nil
            }
            else {
                // either no cards are face up or two cards are already face up
                for flipDownIndex in cards.indices { cards[flipDownIndex].isFaceUp = false }
                indexOfFaceUpCard = index
            }
            cards[index].isFaceUp = true
            flipCount += 1
        }
    }
    
}
