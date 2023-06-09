//
//  ContentView.swift
//  Animations
//
//  Created by Juliana Nielson on 9/30/22.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var animationAmount2 = 0.0
    
    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(.easeInOut(duration: 1)), in: 1...10)

            Spacer()
            
            Button("Tap Me") {
                    withAnimation {
                        animationAmount2 += 360
                    }
                }
                .padding(50)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotation3DEffect(.degrees(animationAmount2), axis: (x: 0, y: 1, z: 0))
            
            Spacer()

            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            
            Spacer()
            
            Button("Tap Me") {
                //animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationAmount)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
