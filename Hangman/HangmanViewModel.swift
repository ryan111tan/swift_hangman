//
//  HangmanState.swift
//  Hangman
//
//  Created by Lauren Go on 2020/09/29.
//  Implemented by Ryan Tan 

import Foundation

class HangmanViewModel : ObservableObject {
    
   
    
  //Declared the published variables necessary for this ObservableObject to work.
    
    @Published var incorrectGuesses: Int = 0
    @Published var progress: String = ""
    @Published var incorrect:[Character] = []
    @Published var gameOver: Bool = false
    var phrase: String = ""
    let numOfGuesses = 6
    
   //List of basketball player names that will serve as the prompt for hangman.
    let phrases: [String] = ["lebronjames", "kevindurant", "stephcurry", "jimmybutler", "kawhileonard", "lukadoncic", "jamesharden", "giannisantetokounmpo", "paulgeorge", "klaythompson", "kembawalker", "russellwestbrook", "joelembiid", "kristapsporzingis", "nikolajokic", "kyrieirving", "bensimmons", "bradleybeal", "draymondgreen"] // you can change these
    
    /** Initializes a new game. */
    init() {
        restart()
    }
    
    
    /** Resets model properties to restart game. */
    func restart() {
        //Pick a phrase from the list of names
        //reset the progress, incorrectGuesses, and the incorrect array.
        phrase = phrases.randomElement()!
        incorrectGuesses = 0
        progress = ""
        for _ in phrase {
            progress.append("-")
        }
        incorrect = []
        gameOver = false
    }
    
    /**
     Checks if the game has reached a lose state.
     - Returns: A Boolean for if the user won or not and has guesses left.
     */
    public func didLose() -> Bool {
        //return if you lost.
        return incorrectGuesses >= numOfGuesses
    }
    
    /**
     Checks if the game has reached a win state.
     - Returns: A Boolean for if the user won or not and has guesses left.
     */
    public func didWin() -> Bool {
        //return if you won.
        if (incorrectGuesses < numOfGuesses) && (progress.lowercased() == phrase.lowercased())  {
            return true
        } else {
            return false
        }
    }
    
    /**
     Processes the user's guess.
     - Parameter guess letter: Character for the letter that is being guessed.
     */
    func makeGuess(guess_letter: Character) {
        //first determine the letter in question.
        //Iterate through each letter of the phrase, if the phrase contains the letter in question, then update the letter.
        let lcLetter = Character(guess_letter.lowercased())
        if(phrase.contains(lcLetter)) {
            
            let swapped = phrase.map{ c in progress.contains(c) || lcLetter == c ? c: Character("-")}
            progress = String(swapped)
            } else {
                if(!incorrect.contains(lcLetter)) {
                    incorrect.append(lcLetter)
                    incorrectGuesses += 1
                    
                }
            }
        }
    
    /**
     Returns a message to notify the winner if they won or not
     - Returns: Message depending on whether they won or not
     */
    public func getFinalMessage() -> String {
        if(didWin()){
            return "YOU WON!"
        } else {
            return "You Lose! The name was ".appending(phrase).appending("!")
        }
    }
}
