//
//  Animations2.swift
//  Animations
//
//  Created by Juliana Nielson on 6/2/23.
//

import SwiftUI

struct Animations2: View {
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    let letters = Array("Hello SwiftUI")
    @State private var stringEnabled = false
    @State private var stringDragAmount = CGSize.zero
    
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? .blue : .red)
            .animation(.default, value: enabled)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
            
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { _ in dragAmount = .zero }
                )
                .animation(.spring(), value: dragAmount)
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count, id: \.self) { num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(stringEnabled ? .blue : .red)
                        .offset(stringDragAmount)
                        .animation(.default.delay(Double(num) / 20), value: stringDragAmount)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { stringDragAmount = $0.translation }
                    .onEnded { _ in
                        stringDragAmount = .zero
                        stringEnabled.toggle()
                    }
            )
            
            VStack {
                Button("Tap Me") {
                    withAnimation {
                        isShowingRed.toggle()
                    }
                }
                
                Spacer()

                if isShowingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                    //For reasons unknown to me, the insertion animation never plays on this rectangle.
                }
            }
        }
    }
}

struct Animations2_Previews: PreviewProvider {
    static var previews: some View {
        Animations2()
    }
}
