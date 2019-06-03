//
//  ViewController.swift
//  Concentration
//
//  Created by Amr Kebesh on 5/29/19.
//  Copyright © 2019 Amr Kebesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    

    @IBAction func resetDisplay(_ sender: UIButton) {
       
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = resetEmojis()
        flipCount = 0
        updateViewFromModel()
        
        //Moving between StoryBoards
       /*
        let storyBoard = UIStoryboard(name:"Main",bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController")as UIViewController
        present(vc,animated: false, completion: nil)
        */
        print("Reset")
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        }
    }
    
    func updateViewFromModel() {
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
    
    
    let halloweenThemeEmojis = ["🎃","👻","🐤","🐝","🦉","🕷"]
    
    var emoji = [Int:String]()
    lazy var emojiChoices = [String](resetEmojis())
    
    func resetEmojis() -> [String]{
        //TODO Pick random theme
        return halloweenThemeEmojis
    }
    
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil , emojiChoices.count > 0{
            
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

