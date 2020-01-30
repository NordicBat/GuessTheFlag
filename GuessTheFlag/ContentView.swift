//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Gabriel Meira on 30.01.20.
//  Copyright © 2020 Gabriel Meira. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreMessage = ""

    @State private var score = 0

    @State private var alertMessage = ""



    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .leading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of: ")
                        .foregroundColor(.white)

                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                        .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 2)
                        )
                    }
                }

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)

                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreMessage),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("Continue?")) {
                    self.newQuestion()
                })
        }
    }

    private func flagTapped(_ number: Int) {
        let isCorrect = number == correctAnswer
        scoreMessage = isCorrect ? "Correct" : "Wrong"
        score = isCorrect ? score + 1 : score - 1
        alertMessage = isCorrect ? "You guessed it right!" : "No, this it the flag of \(countries[number])"

        showingScore = true
    }

    private func newQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
