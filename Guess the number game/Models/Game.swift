//
//  Game.swift
//  Guess the number game
//
//  Created by Sebastine Odeh on 02/02/2023.
//

import Foundation

struct Game {
    var guess = 0;
    var totalScore = 0;
    var roundScore = 0;
    
    init() {
        self.newGame()
    }
    
    init(randomGuess: Int) {
        guess = randomGuess;
    }
    
    mutating func newGame(testValue: Int? = nil) {
        roundScore = 0;
        guess = testValue ?? Int.random(in: 0...101)
    }
    
    mutating func reset(testValue: Int? = nil) {
        newGame(testValue: testValue);
        totalScore = 0;
    }
    
    mutating func submitGuess(guess: Int) {
        let difference = guess - self.guess;
        
        if (difference == 0) {
            roundScore = 200;
        } else {
            roundScore = 100 - abs(difference);
        }
        
        totalScore += roundScore
    }
    
    
}
