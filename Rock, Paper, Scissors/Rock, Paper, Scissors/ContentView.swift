//
//  ContentView.swift
//  Rock, Paper, Scissors
//
//  Created by Juliana Nielson on 5/31/23.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    let winningMoves = ["Paper", "Scissors", "Rock"]
    let losingMoves = ["Scissors", "Rock", "Paper"]
    
    @State private var appMoveIndex = Int.random(in: 0...2)
    @State private var playerShouldWin = Bool.random()
    @State private var score = 0
    
    var body: some View {
        VStack {
            Text("Your score: \(score)")
            Text("The app chose \(possibleMoves[appMoveIndex])")
            if playerShouldWin {
                Text("Your goal: Win!")
            } else {
                Text("Your goal: Lose!")
            }
            HStack {
                ForEach(0..<3) { number in
                    Button {
                        buttonTapped(playerMoveIndex: number)
                    } label: {
                        Text(possibleMoves[number])
                    }
                }
            }
        }
    }
    
    func buttonTapped(playerMoveIndex: Int) {
        var correctArray: [String] {
            playerShouldWin ? winningMoves : losingMoves
        }
        
        if possibleMoves[playerMoveIndex] == correctArray[appMoveIndex] {
            score += 1
        } else {
            score -= 1
        }
        
        resetRound()
    }
    
    func resetRound() {
        appMoveIndex = Int.random(in: 0...2)
        playerShouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
