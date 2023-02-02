//
//  ScaffoldBody.swift
//  Guess the number game
//
//  Created by Sebastine Odeh on 02/02/2023.
//

import SwiftUI
import Combine

struct ScaffoldBody: View {
    @State private var guessInput: String = "";
    @State private var validation: String? = nil;
    
    @State private var game: Game = Game();
    
    @State private var showDialog: Bool = false;
    
    var body: some View {
        ZStack {
            VStack {
                
                HStack{
                    Spacer();
                    
                    Button("Reset Game") {
                        game.reset();
                        guessInput = "";
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .cornerRadius(12)
                }
               
                
                HStack {
                    Text("🎯🎯Total Score:").font(.title2)
                    
                    Text("\(game.totalScore)").font(.title).foregroundColor(Color.yellow)
                }
                
                Spacer()
                    .frame(height: CGFloat(18))
                
                Text("I'm guessing a number between 1 and 100.\nTake a guess👀")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Spacer()
                    .frame(height: CGFloat(12))
                
                AppOutlineTextField(input: $guessInput, validation: $validation)
                    .keyboardType(.numberPad)
                    .onReceive(Just(guessInput)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if (filtered != newValue) {
                            self.guessInput = filtered
                        }
                    }
                
                Spacer()
                    .frame(height: CGFloat(12))
                
                
                Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                    validation = validateInput(value: guessInput);
                    
                    if (validation == nil) {
                        game.submitGuess(guess: Int(guessInput) ?? 0);
                        withAnimation {
                            showDialog = true;
                        }
                    }
                    
                }
                .padding(.horizontal, 28)
                .padding(.vertical, 16)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(CGFloat(12))

                
            }
            .padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(12), bottom: CGFloat(0), trailing: CGFloat(12)))
            
            if showDialog {
                SuccessDialog(showDialog: $showDialog, guessInput: $guessInput, game: $game).transition(.scale)
            }
        }
    }
    
    func validateInput(value: String) -> String? {
        if (value.isEmpty || Int(value) == nil) {
            return "Please input a number";
        }
        
        if (Int(value) ?? 0 > 100) {
            return "Guess out of bounds, please try again";
        }
        
        return nil;
    }
}

struct AppOutlineTextField: View {
    @Binding var input: String;
    @Binding var validation: String?;
    
    var body: some View {
        
        VStack {
            TextField("Guess", text: $input)
                .padding(.horizontal, 12)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            if (validation != nil) {
                Text(validation ?? "").font(.caption).foregroundColor(Color.red)
            }
            
        }
    }
}

struct SuccessDialog: View {
    @Binding var showDialog: Bool;
    @Binding var guessInput: String;
    @Binding var game: Game;
    
    var body: some View {
        
        ZStack {
            Color.black.opacity(0.3)
            
            VStack {
                Text("Congratulations🎉🎉🎉, I guessed \(game.guess).\nYou score \(game.roundScore) in this round and your total score is \(game.totalScore)")
                    .multilineTextAlignment(.center)
                
                Spacer()
                    .frame(height: CGFloat(16))
                
                HStack(spacing: 16) {
                    Button("Continue to new round"){
                        game.newGame();
                        guessInput = "";
                        showDialog = false;
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(12)
                    
                    
                    Button("Reset game"){
                        game.reset();
                        guessInput = "";
                        showDialog = false;
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(12)
                    
                }
            }
            .padding(18)
            .background(Color.white)
        }.ignoresSafeArea()
    }
}

struct ScaffoldBody_Previews: PreviewProvider {
    static var previews: some View {
        ScaffoldBody()
    }
}
