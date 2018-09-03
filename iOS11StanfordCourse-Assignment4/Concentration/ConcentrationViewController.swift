//
//  ConcentrationViewController.swift
//  iOS11StanfordCourse-Assignment1
//
//  Created by Natxo Raga Llorens on 12/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import UIKit


class ConcentrationViewController: UIViewController {

    // Model
    var game: ConcentrationGame! {
        didSet { updateViewFromModel() }
    }
    
    // View
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    var themes = [
        ConcentrationTheme(emojis: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🧛🏻‍♂️", "🧟‍♂️"], primaryColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), secondaryColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
        ConcentrationTheme(emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐵"], primaryColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), secondaryColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        ConcentrationTheme(emojis: ["🦆", "🦅", "🦋", "🐌", "🐞", "🐢", "🐍", "🦑", "🦐", "🦀", "🐬", "🐅", "🦍", "🐘", "🐪", "🦒", "🐄", "🐖", "🐏", "🐓", "🐇"], primaryColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), secondaryColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        ConcentrationTheme(emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🏒", "🏑", "🏏"], primaryColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), secondaryColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
        ConcentrationTheme(emojis: ["😂", "☺️", "😇", "🙃", "😜", "🤨", "🤩", "😏", "😫", "😭", "🤬", "🤯", "😱", "🤫", "🤥", "🙄", "😴", "🤤", "😵", "🤧", "🤒"], primaryColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), secondaryColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
        ConcentrationTheme(emojis: ["🤧", "🌂", "🌨", "⛈", "❄️", "⛄️", "☔️", "⛷", "🏂", "🎄", "🎅🏼"], primaryColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), secondaryColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    ]
    
    var chosenTheme: ConcentrationTheme!
    var emoji: [Int:String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        let cardNumber = cardButtons.index(of: sender)
        game.chooseCard(at: cardNumber!)
        updateViewFromModel()
    }
    
    func newGame() {
        // set random theme
        let randomThemeIndex = Int(arc4random_uniform(UInt32(themes.count)))
        chosenTheme = themes[randomThemeIndex]
        emoji = [Int:String]()
        
        game = ConcentrationGame(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    }
    
    func updateViewFromModel() {
        // cards
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : chosenTheme.primaryColor
            }
        }
        // flips & score
        flipCountLabel.text = "Flips\n\(game.flipCount)"
        flipCountLabel.textColor = chosenTheme.primaryColor
        scoreLabel.text = "Score\n\(game.score)"
        scoreLabel.textColor = chosenTheme.primaryColor
        
        // new game button & background
        newGameButton.setTitleColor(chosenTheme.primaryColor, for: UIControlState.normal)
        view.backgroundColor = chosenTheme.secondaryColor
    }
    
    func emoji(for card: ConcentrationCard) -> String {
        if emoji[card.identifier] == nil {
            if let randomEmoji = chosenTheme.getRandomEmoji() {
                emoji[card.identifier] = randomEmoji
            }
        }
        return emoji[card.identifier] ?? "?"
    }

}

