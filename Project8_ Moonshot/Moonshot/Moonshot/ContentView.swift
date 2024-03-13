//
//  ContentView.swift
//  Moonshot
//
//  Created by Ahmet Faruk Arvas on 18.01.2024.
//

import SwiftUI




struct ContentView: View {

    let astronauts:[String: Astronauts] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let collums = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: collums){
                    ForEach(missions) { mission in
                        NavigationLink{
                            MissionView(mission: mission, astronaut: astronauts)
                        } label: {
                            VStack{
                                Image(mission.ImageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100,height: 100)
                                    .padding()
                                VStack{
                                    Text(mission.DisplayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBacground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBacground)
                            )
                            
                            
                        }
                        
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            
        }
    }
}

#Preview {
    ContentView()
}
