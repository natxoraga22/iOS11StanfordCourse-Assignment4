//
//  ConcentrationVC.swift
//  iOS11StanfordCourse-Assignment1
//
//  Created by Natxo Raga Llorens on 12/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import UIKit


class ConcentrationVC: UIViewController {

    // MARK: - Model
    
    private var game: ConcentrationGame! {
        didSet { updateViewFromModel() }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var cardButtonsStackView: UIStackView!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var counterSeparator = "\n"
    
    // MARK: - Theme
    
    private var chosenTheme: ConcentrationTheme!
    private var emoji: [Int:String]!
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrangeViews(with: view.frame.size)
    }
    
    // MARK: - IBActions
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        newGame()
    }
    
    private func newGame() {
        emoji = [:]
        game = ConcentrationGame(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        let cardNumber = cardButtons.index(of: sender)
        game.chooseCard(at: cardNumber!)
        updateViewFromModel()
    }
    
    // MARK: - Model-View synchronization

    private func updateViewFromModel() {
        // cards
        for (index, button) in cardButtons.enumerated() {
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : chosenTheme.primaryColor
            }
        }
        // flips & score
        flipCountLabel.text = "Flips\(counterSeparator)\(game.flipCount)"
        flipCountLabel.textColor = chosenTheme.primaryColor
        scoreLabel.text = "Score\(counterSeparator)\(game.score)"
        scoreLabel.textColor = chosenTheme.primaryColor
        
        // new game button & background
        newGameButton.setTitleColor(chosenTheme.primaryColor, for: .normal)
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
    
    // MARK: - UIContentContainer Protocol
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        arrangeViews(with: size)
    }
    
    private func arrangeViews(with size: CGSize) {
        cardButtonsStackView.axis = size.height > size.width ? .vertical : .horizontal
        counterSeparator = size.height > size.width ? "\n" : ": "
    }

}

