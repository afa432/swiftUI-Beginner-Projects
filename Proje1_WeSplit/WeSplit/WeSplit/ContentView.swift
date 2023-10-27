//
//  ContentView.swift
//  WeSplit
//
//  Created by Ahmet Faruk Arvas on 22.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var focusState: Bool
    var totalCheck:Double{
        let peopleCount  = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue     = Double(checkAmount/100 * tipSelection)
        
        let grandTotal   = checkAmount  + tipValue
        
        return grandTotal
            }
    let tipPercentages = [10,15,20,25,30,0]
    
    var totalPersonn: Double{
        let peopleCount  = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue     = Double(checkAmount/100 * tipSelection)
        
        let grandTotal   = checkAmount  + tipValue
        let amountPerPerson = grandTotal/peopleCount
        
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amaount", value: $checkAmount , format:  .currency(code: Locale.current.currency?.identifier ?? "USD")
                    ).keyboardType(.decimalPad)
                        .focused($focusState)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("How much do you want to tip") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total Check"){
                    Text(totalCheck,  format:  .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person"){
                    Text(totalPersonn, format:  .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
            }.navigationTitle("WeSplit")
                .toolbar{
                    if focusState {
                        Button("Done"){
                            focusState = false
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
