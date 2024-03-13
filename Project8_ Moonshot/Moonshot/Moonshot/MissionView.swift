//
//  MissionView.swift
//  Moonshot
//
//  Created by Ahmet Faruk Arvas on 27.01.2024.
//

import SwiftUI

struct MissionView: View {
    struct crewMember{
        let role: String
        let astronaut: Astronauts
    }
    
    let mission: Mission
    let crew: [crewMember]
    
    var body: some View {
        ScrollView{
            VStack{
                Image(mission.ImageName)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) {widht, axis in
                        widht * 0.6
                    }
                VStack(alignment: .leading){
                    
                    Rectangle()
                        .frame(height: 2)
                        .padding(.vertical)
                        .foregroundStyle(.lightBacground)
                    
                    Text("Mission Higlits")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .padding(.vertical)
                        .foregroundStyle(.lightBacground)
                    
                    Text("Crew")
                        .font(.title)
                        .bold()
                        .padding(.bottom,5)
                }
                .padding(.horizontal)
            }
            
            ScrollView(.horizontal , showsIndicators: false){
                HStack{
                    ForEach(crew, id: \.role) { crewMember  in
                        NavigationLink{
                            AstronautView(astronaut: crewMember.astronaut)
                        }label: {
                            HStack{
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(.capsule)
                                    .overlay(
                                        Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                        )
                                
                                VStack(alignment: .leading){
                                    Text(crewMember.astronaut.name)
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                            
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            
            
            
        }
        .navigationTitle(mission.DisplayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronaut: [String: Astronauts]) {
        self.mission = mission
        self.crew =  mission.crew.map{ member in
            if let astronaut  = astronaut[member.name]{
                return crewMember(role: member.role, astronaut: astronaut)
            }else{
                fatalError("missin \(member.name )")
            }
                
            
        }
    }
}
#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronaut: [String: Astronauts] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronaut: astronaut)
        .preferredColorScheme(.dark)
}
