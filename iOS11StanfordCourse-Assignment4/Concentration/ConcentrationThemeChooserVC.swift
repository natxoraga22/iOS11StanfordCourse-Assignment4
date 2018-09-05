//
//  ConcentrationThemeChooserVC.swift
//  iOS11StanfordCourse-Assignment4
//
//  Created by Natxo Raga Llorens on 4/9/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import UIKit


class ConcentrationThemeChooserVC: UIViewController {

    // MARK: - Available themes
    
    let themes = [
        ConcentrationTheme(name: "Halloween", emojis: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🧛🏻‍♂️", "🧟‍♂️"],
                           primaryColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), secondaryColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
        ConcentrationTheme(name: "Animal faces", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐵"],
                           primaryColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), secondaryColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        ConcentrationTheme(name: "Animals", emojis: ["🦆", "🦅", "🦋", "🐌", "🐞", "🐢", "🐍", "🦑", "🦐", "🦀", "🐬", "🐅", "🦍", "🐘", "🐪", "🦒", "🐄", "🐖", "🐏", "🐓", "🐇"],
                           primaryColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), secondaryColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        ConcentrationTheme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🏒", "🏑", "🏏"],
                           primaryColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), secondaryColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
        ConcentrationTheme(name: "Faces", emojis: ["😂", "☺️", "😇", "🙃", "😜", "🤨", "🤩", "😏", "😫", "😭", "🤬", "🤯", "😱", "🤫", "🤥", "🙄", "😴", "🤤", "😵", "🤧", "🤒"],
                           primaryColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), secondaryColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
        ConcentrationTheme(name: "Winter", emojis: ["🤧", "🌂", "🌨", "⛈", "❄️", "⛄️", "☔️", "⛷", "🏂", "🎄", "🎅🏼"],
                           primaryColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), secondaryColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    ]
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var buttonsParentStackView: UIStackView!
    @IBOutlet weak var buttonsStackView1: UIStackView!
    @IBOutlet weak var buttonsStackView2: UIStackView!
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Concentration"
        
        // buttons layout for each theme
        buttonsStackView1.subviews.forEach { subview in subview.removeFromSuperview() }
        buttonsStackView2.subviews.forEach { subview in subview.removeFromSuperview() }
        for (index, theme) in themes.enumerated() {
            if index < themes.count / 2 { buttonsStackView1.addArrangedSubview(buttonForTheme(theme)) }
            else { buttonsStackView2.addArrangedSubview(buttonForTheme(theme)) }
        }
    }

    private func buttonForTheme(_ theme: ConcentrationTheme) -> UIButton {
        let themeButton = UIButton(type: .custom)
        // Title
        themeButton.setTitle(" \(theme.name) ", for: .normal)
        themeButton.setTitleColor(theme.secondaryColor, for: .normal)
        themeButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).withSize(35.0)
        // Background
        themeButton.backgroundColor = theme.primaryColor
        themeButton.layer.cornerRadius = 8.0
        // Action
        themeButton.addTarget(self, action: #selector(touchTheme(_:)), for: .touchUpInside)
        return themeButton
    }
    
    // MARK: - IBActions
    
    @IBAction func touchTheme(_ sender: UIButton) {
        performSegue(withIdentifier: "Show Concentration Game", sender: sender)
    }
    
    // MARK: - UIContentContainer Protocol
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        buttonsParentStackView.axis = size.height > size.width ? .vertical : .horizontal
    }
    

    /*
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
