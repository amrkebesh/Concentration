//
//  ViewController.swift
//  Concentration
//
//  Created by Amr Kebesh on 5/29/19.
//  Copyright © 2019 Amr Kebesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
            return ((cardButtons.count + 1) / 2)
    }
  /*
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
 */
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction func resetDisplay(_ sender: UIButton) {
       
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = resetEmojis()
        updateViewFromModel()
        
        //Moving between StoryBoards
       /*
        let storyBoard = UIStoryboard(name:"Main",bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController")as UIViewController
        present(vc,animated: false, completion: nil)
        */
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        }
    }
    
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    
    private let halloweenThemeEmojis = ["🎃","👻","🐤","🐝","🦉","🕷"]
    private let faceThemeEmojis = ["😎","🥶","😡","😂","🤪","😈"]
    private let animalsThemeEmojis = ["🐼","🐶","🐰","🙉","🐆","🐏"]
    
    private var themes = [[String]]()
    
    private var emoji = [Int:String]()
    lazy private var emojiChoices = [String](resetEmojis())
    
    func resetEmojis() -> [String]{
        //Starting a new game with a new random theme
        
        themes.removeAll()
        themes.append(halloweenThemeEmojis)
        themes.append(faceThemeEmojis)
        themes.append(animalsThemeEmojis)
        
        let randomTheme = themes[themes.count.arc4random]
        
        return randomTheme
        
    }
    
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil , emojiChoices.count > 0{
            
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return 0
        }
    }
}
