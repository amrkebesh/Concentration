//
//  Card.swift
//  Concentration
//
//  Created by Amr Kebesh on 5/30/19.
//  Copyright © 2019 Amr Kebesh. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var involvedInMismatchBefore = false
    var isTwinMismatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1;
        return identifierFactory;
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier();
    }
}
