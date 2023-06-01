import UIKit

var greeting = "Hello, playground"

//
//  ContentView.swift
//  Rock, Paper, Scissors
//
//  Created by Juliana Nielson on 5/31/23.
//

import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var userPlay = "_"
    
    let userPlays = ["Rock", "Paper", "Scissors"]
    
    var rockCalculator: () -> Void {
        return calculateRockScore
    }
    var paperCalculator: () -> Void {
        return calculatePaperScore
    }
    var scissorsCalculator: () -> Void {
        return calculateScissorsScore
    }
    
    
    var appPlay: String {
        let randomizer = Int.random(in: 1...3)
        switch randomizer {
        case 1:
            return "Rock"
        case 2:
            return "Paper"
        case 3:
            return "Scissors"
        default:
            return "You broke the matrix."
        }
    }
    
    var userGoal: String {
        let randomizer = Bool.random()
        let response = randomizer ? "Win!" : "Lose!"
        return response
    }
    
    var didCompleteGoal: Bool? {
        switch (userPlay, appPlay) {
        case ("Rock", "Rock"), ("Paper", "Paper"), ("Scissors", "Scissors"):
            return false
        case ("Rock", "Paper"), ("Paper", "Scissors"), ("Scissors", "Rock"):
            if userGoal == "Win!" {
                return false
            } else {
                return true
            }
        case ("Rock", "Scissors"), ("Paper", "Rock"), ("Scissors", "Paper"):
            if userGoal == "Win!" {
                return true
            } else {
                return false
            }
        default:
            print("Error, somehow played an impossible combination")
            return nil
        }
    }
    
    func calculateRockScore() {
        userPlay = "Rock"
        guard let didCompleteGoal = didCompleteGoal else { print("It's broken!"); return }
        
        if didCompleteGoal {
            score += 1
        } else {
            score -= 1
        }
    }
    
    func calculatePaperScore() {
        userPlay = "Paper"
        guard let didCompleteGoal = didCompleteGoal else { print("It's broken!"); return }
        
        if didCompleteGoal {
            score += 1
        } else {
            score -= 1
        }
    }
    
    func calculateScissorsScore() {
        userPlay = "Scissors"
        guard let didCompleteGoal = didCompleteGoal else { print("It's broken!"); return }
        
        if didCompleteGoal {
            score += 1
        } else {
            score -= 1
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Your Score: \(score)")
                Spacer()
            }
            VStack {
                VStack {
                    Text("The app has chosen:")
                    Text(appPlay)
                        .font(.largeTitle)
                }
                .padding()
                
                VStack {
                    Text("Your goal:")
                    Text(userGoal)
                        .font(.largeTitle)
                }
                .padding()
                
                VStack {
                    Text("What will you play?")
                        .font(.caption)
                    HStack {
                        Button("Rock", action: rockCalculator)
                        Button("Paper", action: paperCalculator)
                        Button("Scissors", action: scissorsCalculator)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
