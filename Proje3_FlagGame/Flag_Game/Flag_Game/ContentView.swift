//
//  ContentView.swift
//  Flag_Game
//
//  Created by Ahmet Faruk Arvas on 28.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correcctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle   = ""
    @State private var score = 0
    @State private var aaaaa = 1
    
    var body: some View {
        
        
            ZStack{
                RadialGradient(stops:[
                    .init(color: Color(red:0.1 , green: 0.2 , blue: 0.45 ), location: 0.3),
                    .init(color: Color(red: 0.90, green: 0.15, blue: 0.26), location: 0.3)
                ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
                
                VStack{
                    Spacer()
                    Text("Gues the Flag")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                VStack(spacing: 30 ){
                    VStack{
                        
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correcctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    ForEach(0..<3){number in
                        Button(){
                            aaaaa = number
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical , 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                    
                Spacer()
                Spacer()
                    
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                Spacer()
            }
                .padding()
                
        }
        .alert(scoreTitle,isPresented: $showingScore){
            Button("Continue",action: askQuestion)
        }message: {
            if(scoreTitle == "Correct"){
                Text("That's correct your score \(score)")
            }else{
                Text("no that's the flag of \(countries[aaaaa])")
            }
        }
    }
    
    func flagTapped(_ number: Int ){
        if(number == correcctAnswer){
            scoreTitle = "Correct"
            score += 1
        }else{
            scoreTitle = "False"
        }
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correcctAnswer = Int.random(in: 0...2)
    }
}
#Preview {
    ContentView()
}
