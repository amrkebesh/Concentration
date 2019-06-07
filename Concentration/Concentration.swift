//
//  Concentration.swift
//  Concentration
//
//  Created by Amr Kebesh on 5/30/19.
//  Copyright © 2019 Amr Kebesh. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil{
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    var flipCount = 0
    var score = 0
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards range")

        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check for match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                
                else{
                    
                    cards[matchIndex].involvedInMismatchBefore = true
                    
                    //Decreasing score
                    if cards[index].involvedInMismatchBefore && cards[index].isTwinMismatched  {
                        score -= 1
                    }
                    if  cards[matchIndex].involvedInMismatchBefore && cards[matchIndex].isTwinMismatched {
                        score -= 1
                    }
                    cards[index].involvedInMismatchBefore = true
                    
                    for pairIdentifier in cards.indices{
                        if cards[pairIdentifier].identifier == cards[index].identifier {
                            cards[pairIdentifier].isTwinMismatched = true
                        }
                        
                        if cards[pairIdentifier].identifier == cards[matchIndex].identifier{
                            cards[pairIdentifier].isTwinMismatched = true
                        }
                    }
                
                }

                cards[index].isFaceUp = true

            }
            else{
                indexOfOneAndOnlyFaceUpCard = index
            }
            
            flipCount += 1
        }
    }
    
    private var pairsOfCards = [Int:[Card]]()
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you should have at least one pair of cards")
        
        for _ in 0..<numberOfPairsOfCards {
            
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        
        //Shuffling cards here
        cards.shuffle();
        
        
    }
}
