//
//  ConcentrationCard.swift
//  iOS11StanfordCourse-Assignment1
//
//  Created by Natxo Raga Llorens on 12/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import Foundation


struct ConcentrationCard {
    
    // Class properties & methods
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    // Variable properties & methods
    var isFaceUp = false {
        didSet { if isFaceUp { hasBeenFaceUp = true } }
    }
    var hasBeenFaceUp = false
    var isMatched = false
    var identifier: Int
    
    init() {
        self.identifier = ConcentrationCard.getUniqueIdentifier()
    }
    
}
