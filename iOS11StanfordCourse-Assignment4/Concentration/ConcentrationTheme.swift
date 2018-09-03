//
//  ConcentrationTheme.swift
//  iOS11StanfordCourse-Assignment1
//
//  Created by Natxo Raga Llorens on 16/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import UIKit


struct ConcentrationTheme {
    
    var emojis: [String]
    var primaryColor: UIColor       // card back, text
    var secondaryColor: UIColor     // background
    
    mutating func getRandomEmoji() -> String? {
        if emojis.isEmpty { return nil }
        let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
        return emojis.remove(at: randomIndex)
    }
    
}
