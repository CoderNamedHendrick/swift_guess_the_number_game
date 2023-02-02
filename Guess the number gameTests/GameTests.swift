//
//  GameTests.swift
//  Guess the number gameTests
//
//  Created by Sebastine Odeh on 02/02/2023.
//

import XCTest
@testable import Guess_the_number_game

final class GameTests: XCTestCase {
    
    var game: Game!;

    override func setUpWithError() throws {
        game = Game(randomGuess: 30)
    }

    override func tearDownWithError() throws {
        game = nil;
    }

    func testCorrectInstanceIsCreated() {
        XCTAssertEqual(game.totalScore, 0);
        XCTAssertEqual(game.roundScore, 0);
        XCTAssertEqual(game.guess, 30);
    }
    
    func testScoreUpdateIsCorrect() {
        game.submitGuess(guess: 50);
        XCTAssertEqual(game.totalScore, 80);
        
        game.submitGuess(guess: 29);
        XCTAssertEqual(game.totalScore, 179);
        
        game.submitGuess(guess: 30);
        XCTAssertEqual(game.totalScore, 379);
    }
    
    func testRoundScoreUpdateIsCorrect() {
        game.submitGuess(guess: 50);
        XCTAssertEqual(game.totalScore, 80);
        
        game.submitGuess(guess: 29);
        XCTAssertEqual(game.totalScore, 179);
        
        game.newGame(testValue: 10);
        
        XCTAssertEqual(game.roundScore, 0);
    }
    
    func testPlayMultipleGamesSuccess() {
        game.submitGuess(guess: 20);
        XCTAssertEqual(game.totalScore, 90);
        
        game.newGame(testValue: 20);
        
        game.submitGuess(guess: 40);
        XCTAssertEqual(game.totalScore, 170);
    }
    
    func testPlayMultipleGamesResetAndPlayAgain() {
        game.submitGuess(guess: 50);
        game.submitGuess(guess: 29);
        XCTAssertEqual(game.totalScore, 179);
        
        game.reset(testValue: 80);
        
        XCTAssertEqual(game.roundScore, 0);
        XCTAssertEqual(game.totalScore, 0);
        
        game.submitGuess(guess: 40);
        game.submitGuess(guess: 80);
        
        XCTAssertEqual(game.roundScore, 200);
        XCTAssertEqual(game.totalScore, 260);
    }
}
