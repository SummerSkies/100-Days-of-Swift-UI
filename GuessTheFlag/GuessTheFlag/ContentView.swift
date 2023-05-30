//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Juliana Nielson on 9/15/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    let customBlue = Color(red: 0.1, green: 0.2, blue: 0.45)
    let customRed = Color(red: 0.76, green: 0.15, blue: 0.26)
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [customBlue, customRed], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            Color.white
                .frame(width: 250, height: 405)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(y: 45)
            VStack (spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                        .offset(y: -15)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                        .offset(y: -15)
                }
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label : {
                        Image(countries[number])
                            .renderingMode(.original)
                            .shadow(radius: 10)
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Incorrect"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
