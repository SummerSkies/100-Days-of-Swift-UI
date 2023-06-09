//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Juliana Nielson on 9/15/22.
//

import SwiftUI

struct Flag: View {
    var image: String
    
    init(image: String) {
        self.image = image
    }
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .shadow(radius: 10)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var animationAmount = 0.0
    @State private var selectedNumber = -1
    @State private var opactityAmount = 1.0
    @State private var scaleAmount = 1.0
    
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
                        withAnimation {
                            animationAmount += 360
                            opactityAmount = 0.25
                            scaleAmount = 0.9
                            flagTapped(number)
                        }
                    } label : {
                        Flag(image: countries[number])
                    }
                    .rotation3DEffect(.degrees(self.selectedNumber == number ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.selectedNumber != number ? opactityAmount : 1)
                    .scaleEffect(self.selectedNumber != number ? scaleAmount : 1)
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
        self.selectedNumber = number
        
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
        selectedNumber = -1
        opactityAmount = 1
        scaleAmount = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
