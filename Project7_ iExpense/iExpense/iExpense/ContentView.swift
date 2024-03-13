//
//  ContentView.swift
//  iExpense
//
//  Created by Ahmet Faruk Arvas on 24.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(numbers, id: \.self ){
                        Text("Row \($0)")
                    }.onDelete(perform: Ondelete)
                }
            }
            
            Button("Add Number") {
                numbers.append(currentNumber)
                currentNumber += 1
            }
            .toolbar{
                EditButton()
            }
        }
    }
    func Ondelete(at offset: IndexSet){
        numbers.remove(atOffsets: offset)
    }
    
}

#Preview {
    ContentView()
}
