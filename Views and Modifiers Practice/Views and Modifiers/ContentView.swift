//
//  ContentView.swift
//  Views and Modifiers
//
//  Created by Juliana Nielson on 9/19/22.
//

import SwiftUI

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    
    func largeBlueFont() -> some View {
        modifier(BlueFont())
    }
}

struct ContentView: View {
    @State private var usingWhiteBackground = false
    @ViewBuilder var languages: some View {
        Group {
            Text("English")
            Text("Spanish")
            Text("French")
            Text("German")
        }
    }
    
    let regularWave = Text("Rock your hand back and forth in greeting!")
    let fiveFingerWave = Text("Flutter your fingers. Maybe he'll notice!")
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Respond?") {
                print(type(of: self.body))
                usingWhiteBackground.toggle()
            }
            .frame(width: 110, height: 75)
            .background(usingWhiteBackground ? .white : .black)
            .padding()
            
            VStack {
                Text("What's up?")
                    .font(.largeTitle)
                Text("Hello!")
                Text("Goodbye.")
                Text("What's your name?")
            }
            .font(.title)
            
            VStack {
                regularWave
                    .foregroundColor(.primary)
                fiveFingerWave
                    .foregroundColor(.secondary)
                Text("Hello World")
                    .titleStyle()
                    .padding()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.cyan)
        .padding()
        .background(.teal)
        .padding()
        .background(.mint)
        .padding()
        .background(.green)
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct BlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50, weight: .heavy))
            .foregroundColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
