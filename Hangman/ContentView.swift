//
//  ContentView.swift
//  Hangman
//
//  Created by Lauren Go on 2020/09/29.
//

import SwiftUI

struct ContentView: View {
    
    // TODO: an ObservedObject for the HangmanViewModel
    
    // TODO: Build the Hangman view!
    // 1. 2D array of button values for user inputs and the keyboard.
    // 2. Image that updates based on the HangmanViewModel's incorrect guesses count.
    // 3. Text that displays the incorrect guesses and updates based on the HangmanViewModel's incorrect guesses array.
    // 4. ForEach loop to create the custom keyboard. Reference the calculator app we created in lecture as it ~very~ similar.
    // 5. Add an alert. To be covered in Lecture 5.
    var body: some View {
        Text("Hangman")
    }
}

// TODO: Create KeyboardButtonView struct.
// Reference the CalculatorButtonView struct we created for the calculator app in lecture demos as it ~very~ similar.

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
