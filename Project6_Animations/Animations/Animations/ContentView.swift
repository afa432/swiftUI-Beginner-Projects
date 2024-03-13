//
//  ContentView.swift
//  Animations
//
//  Created by Ahmet Faruk Arvas on 20.12.2023.
//

import SwiftUI

struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        VStack(spacing: 80){
            Text("Pres H and drag")
            
            HStack(spacing: 5) {
                
                
                ForEach(0..<letters.count, id: \.self){ num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .red : .blue)
                        .offset(dragAmount)
                        .animation(.linear .delay(Double(num) / 20), value: dragAmount)
                    
                }
            }
        }
        .gesture(
        DragGesture()
            .onChanged{dragAmount = $0.translation}
            .onEnded{ _ in
                dragAmount = .zero
                enabled.toggle()
            }
        )
    }
}
#Preview {
    ContentView()
}
