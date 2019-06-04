//
//  Concentration.swift
//  Concentration
//
//  Created by Amr Kebesh on 5/30/19.
//  Copyright © 2019 Amr Kebesh. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var flipCount = 0
    var score = 0
    
    func chooseCard(at index: Int) {

        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check for match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                
                else{
                    //Decreasing score
                    if cards[index].involvedInMismatchBefore || cards[matchIndex].involvedInMismatchBefore {
                        score -= 1
                    }
                    
                    
                    for pairIdentifier in cards.indices{
                        if cards[pairIdentifier].identifier == cards[index].identifier {
                            cards[pairIdentifier].involvedInMismatchBefore = true
                        }
                        
                        if cards[pairIdentifier].identifier == cards[matchIndex].identifier{
                            cards[pairIdentifier].involvedInMismatchBefore = true
                        }
                    }
                
                }

                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else{
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            
            flipCount += 1
        }
    }
    
    var pairsOfCards = [Int:[Card]]()
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        
        //Shuffling cards here
        cards.shuffle();
        
        
    }
}
