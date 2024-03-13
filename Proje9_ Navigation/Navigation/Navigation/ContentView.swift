//
//  ContentView.swift
//  Navigation
//
//  Created by Ahmet Faruk Arvas on 14.02.2024.
//

import SwiftUI

struct DetailedView: View {
    var number: Int
    @Binding var path: NavigationPath
    
    var body: some View{
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("number: \(number)")
            .toolbar{
                Button("Home"){
                    path = NavigationPath()
                }
            }
    }
}

struct ContentView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            DetailedView(number: 0, path: $path)
                .navigationDestination(for: Int.self) { i in
                    DetailedView(number: i, path: $path)
                }
            }

        }
    }

#Preview {
    ContentView()
}
