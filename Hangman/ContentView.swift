//
//  ContentView.swift
//  Hangman
//
//  Created by Lauren Go on 2020/09/29.
//  Implemented by Ryan Tan 

import SwiftUI

//Enumerated the each cases and the values that they return.
enum letterButton: String {

    case A, B, C ,D, E, F, G
    case H, I, J, K, L, M, N
    case O, P, Q, R, S, T, U
    case V, W, X, Y, Z
    
    var title: String {
        switch self {
        case .A: return "a"
        case .B: return "b"
        case .C: return "c"
        case .D: return "d"
        case .E: return "e"
        case .F: return "f"
        case .G: return "g"
        case .H: return "h"
        case .I: return "i"
        case .J: return "j"
        case .K: return "k"
        case .L: return "l"
        case .M: return "m"
        case .N: return "n"
        case .O: return "o"
        case .P: return "p"
        case .Q: return "q"
        case .R: return "r"
        case .S: return "s"
        case .T: return "t"
        case .U: return "u"
        case .V: return "v"
        case .W: return "w"
        case .X: return "x"
        case .Y: return "y"
        default: return "z"
        }
    }

}


struct ContentView: View {
    
    // an ObservedObject for the HangmanViewModel
    @ObservedObject var hangManEnvironment = HangmanViewModel()
   
    // 2D array of button values for user inputs and the keyboard.
    
    let buttonValues: [[letterButton]] = [
        [.A,.B,.C,.D,.E,.F,.G],
        [.H,.I,.J,.K,.L,.M,.N],
        [.O,.P,.Q,.R,.S,.T,.U],
        [.V,.W,.X,.Y,.Z]
    ]

    var body: some View {
        
        VStack(spacing: 10){
            //HStack of the title text.
            HStack(alignment: .top) {
                Spacer()
                Text("Basketball HangMan")
                    .font(.title2)
                Spacer()
                
            }
            //Hstack of image and restart button.
            HStack{
                hangManView(hangManEnvironment: hangManEnvironment)
                restartButtonView(hangManEnvironment: hangManEnvironment)
            }
            //HStack of the incorrect letters.
            HStack{
                Spacer()
                Text("Inc_Guess:")
                Text(String(hangManEnvironment.incorrect))
                Spacer()
            }
            
            //HStack of hangManEnvironment.progress
            HStack {
                Spacer()
                Text("word")
                    .font(.title2)
                Text(hangManEnvironment.progress)
                    .font(.title2)
                    .background(Color.yellow)
                    .cornerRadius(10)
                Spacer()
            }
            
            //HStack of the  buttons that corresponds to each letter.
        ForEach(buttonValues, id:\.self) { row in
            HStack {
                ForEach(row, id: \.self) {button in
                    KeyboardButtonView(button: button, hangManEnvironment: hangManEnvironment)
                }
            }
        }
        
    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    .padding(.bottom)
        //Alert that when presented with the gameOver becomes true. The
    .alert(isPresented: $hangManEnvironment.gameOver, content: {
            Alert(title: Text("Hangman"), message: Text(hangManEnvironment.getFinalMessage()), dismissButton: .default(Text("Restart"), action: {hangManEnvironment.restart()}))
        })
            
    }


//The restartButton View - press it to restart the game.
struct restartButtonView: View {
        
    @ObservedObject var hangManEnvironment: HangmanViewModel

        
        var body: some View {
            
            Button( action: {
                self.hangManEnvironment.restart()
            }, label: {
                Text("Restart")
            })
            
        }
        
}


// hangManView - Takes a look at the value of num of inc guesses and updates.
struct hangManView: View {
    @ObservedObject var hangManEnvironment: HangmanViewModel
    
    var body: some View {
        switch hangManEnvironment.incorrectGuesses {
        case 1:
            Image("hangman1")
        case 2:
            Image("hangman2")
        case 3:
            Image("hangman3")
        case 4:
            Image("hangman4")
        case 5:
            Image("hangman5")
        case 6:
            Image("hangman6")
        default:
            Image("hangman0")
        }
        
        
    }
}
    
    
    
    
    
    

//keyBoardButton taht looks at the text and create the length based on such things.
struct KeyboardButtonView: View {
    
    var button: letterButton
    
    @ObservedObject var hangManEnvironment: HangmanViewModel
    
    var body: some View {
            
            Button(action: {
                self.hangManEnvironment.makeGuess(guess_letter:  Character(button.title))
                
              // Used to debug hangmanView and Text
              //  self.hangManEnvironment.incorrectGuesses =
              //     self.hangManEnvironment.incorrectGuesses + 1
            
                //Check if the game has ended yet.
                if(self.hangManEnvironment.didLose() || self.hangManEnvironment.didWin()){
                    self.hangManEnvironment.gameOver = true
                }
                
            }, label: {
                Text(button.title)
                .font(.title)
                    .frame(width: self.buttonWidth(), height: self.buttonHeight())
                .foregroundColor(.blue)
                .background(Color.yellow)
                    .cornerRadius(self.buttonHeight())
            })
        }
        
        
    func buttonWidth() -> CGFloat {
            return (UIScreen.main.bounds.width - 6 * 10) / 7
    }
        
    func buttonHeight() -> CGFloat {
            return (UIScreen.main.bounds.width - 6 * 10) / 7
    }
      
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
