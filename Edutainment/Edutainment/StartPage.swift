//
//  ContentView.swift
//  Edutainment
//
//  Created by Juliana Nielson on 6/5/23.
//

import SwiftUI

struct PlayAnimation: View{
    @State private var opacityAnimationAmount = 0.0
    @State private var pushAnimationAmount = 200.0
    
    @State private var animatedText: String
    @State private var shouldPlay: Bool
    
    init(animatedText: String, shouldPlay: Bool) {
        self.animatedText = animatedText
        self.shouldPlay = shouldPlay
    }
    
    var body: some View {
        if shouldPlay {
            Text("\(animatedText)")
                .font(.system(size: 50, weight: .heavy))
                .offset(x: 0, y: pushAnimationAmount)
                .opacity(0 + opacityAnimationAmount)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 0.7).repeatCount(1, autoreverses: true)) {
                        pushAnimationAmount -= 400
                    }
                    withAnimation(Animation.easeIn(duration: 0.2)) {
                        opacityAnimationAmount += 1
                    }
                    withAnimation(Animation.easeIn(duration: 0.2).delay(0.66)) {
                        opacityAnimationAmount -= 1
                    }
                }
        }
    }
}

struct StartPage: View {
    @State private var selectedTable = 0
    @State private var numberOfQuestions = 5
    @State private var submittedAnswer: Int? = nil
    
    @State private var questionCounts = [5, 10, 20]
    
    @State private var gameBegun = false
    @State private var gameQuestions = [Int]()
    @State private var viewedQuestion = ""
    @State private var currentQuestionIndex = 0
    
    @State private var animationAmount = 1.0
    @State private var animatedText = ""
    @State private var viewID = 0
    @State private var shouldPlay = false
    
    let customRed = Color(red: 255 / 255, green: 149 / 255, blue: 149 / 255)
    let customYellow = Color(red: 255 / 255, green: 220 / 255, blue: 74 / 255)
    let translucentWhite = Color(white: 1, opacity: 0.5)

    func beginGame() {
        gameBegun = true
        generateQuestions()
        askQuestion()
    }
    
    func endGame(won: Bool) {
        if won {
            print("Congradulations! You did it.")
        }
        gameBegun = false
        submittedAnswer = nil
        gameQuestions = []
        viewedQuestion = ""
        currentQuestionIndex = 0
        animatedText = ""
    }
    
    func generateQuestions() {
        var questionOptions = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        var generatedQuestions = [Int]()
        
        for _ in 0...numberOfQuestions {
            let randomElement = questionOptions.randomElement()!
            generatedQuestions.append(randomElement)
            questionOptions.removeAll(where: { generatedQuestions.contains($0) })
        }
        
        gameQuestions = generatedQuestions
    }
    
    func askQuestion() {
        viewedQuestion = "\(selectedTable)x\(gameQuestions[currentQuestionIndex])"
    }
    
    func calculateAnswer() -> Bool? {
        guard let submittedAnswer else { return nil }
        let correct = selectedTable * gameQuestions[currentQuestionIndex] == submittedAnswer
        
        if correct {
            animatedText = "Correct!"
            return true
        } else {
            animatedText = "Incorrect!"
            return false
        }
        
    }
    
    var body: some View {
        ZStack {
            Form {
                Section("Game Settings") {
                    Picker("Select the multiplication table you want to practice.", selection: $selectedTable) {
                        ForEach(0..<13) {
                            Text("\($0)x")
                        }
                    }
                    
                    Picker("How many questions would you like to be asked?", selection: $numberOfQuestions) {
                        ForEach(questionCounts, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                }
                .listRowBackground(translucentWhite)
                
                Section(footer:
                            HStack {
                    Spacer()
                    
                    VStack {
                        
                        Button("Let's Go!") {
                            guard !gameBegun else { return }
                            beginGame()
                        }
                        .font(.system(.body))
                        .foregroundColor(.white)
                        .padding(30)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(translucentWhite, lineWidth: 7)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(translucentWhite)
                                .scaleEffect(!gameBegun ? animationAmount : 1)
                                .opacity(2 - animationAmount)
                                .animation(
                                    .easeOut(duration: 1)
                                    .repeatForever(autoreverses: false),
                                    value: animationAmount
                                )
                        )
                        .onAppear {
                            animationAmount = 2
                        }
                        
                        if gameBegun {
                            Text("\(viewedQuestion)")
                                .font(.system(size: 120))
                                .foregroundColor(.white)
                                .padding([.bottom, .top], 30)
                            
                            TextField("What's the answer?", value: $submittedAnswer, format: .number)
                                .padding()
                                .background(translucentWhite)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .foregroundColor(.red)
                                .padding(10)
                            
                            Button("Submit Answer") {
                                
                                let correct = calculateAnswer()
                                if correct == true {
                                    currentQuestionIndex += 1
                                    
                                    currentQuestionIndex <= numberOfQuestions ? askQuestion() : endGame(won: true)
                                }
                                
                                viewID += 1
                                shouldPlay = true
                            }
                            .font(.system(.body))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(translucentWhite, lineWidth: 5)
                            )
                            
                            Button("Resart Game") {
                                endGame(won: false)
                            }
                            .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                })
                {
                    EmptyView()
                }
            }
            .modifier(FormHiddenBackground())
            .background(customRed)
            
            PlayAnimation(animatedText: animatedText, shouldPlay: shouldPlay)
                .id(viewID)
                .foregroundColor(animatedText == "Correct!" ? .green : .red)
            
        }
    }
}

struct FormHiddenBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content.onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear {
                UITableView.appearance().backgroundColor = .systemGroupedBackground
            }
        }
    }
}

struct PracticePage: View {
    
    var body: some View {
        VStack {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}
