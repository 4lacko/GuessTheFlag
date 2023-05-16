//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ayo Moreira on 5/15/23.
//

import SwiftUI

struct ContentView: View {
    @State private var gameOver = false
    @State private var gameOverMessage = ""
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var totalRounds = 5
    @State private var gameRound = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                    
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(gameOverMessage, isPresented: $gameOver) {
            Button("Start Over", action: reset)
        } message: {
            Text("Let's play again!")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[correctAnswer])"
        }
        
        gameRound += 1
        showingScore = true
    }
    
    func askQuestion() {
        if gameRound == totalRounds {
            gameOverMessage = "Game Over! You have \(score) out of \(totalRounds) points."
            gameOver = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func reset() {
        countries.shuffle()
        score = 0
        gameRound = 0
        gameOver = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
