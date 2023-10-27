//
//  ContentView.swift
//  tempetureConversion
//
//  Created by Ahmet Faruk Arvas on 27.10.2023.
//



import SwiftUI

struct ContentView: View {
    
    @State private var enteredValue    = 1.0
    @State private var tempature = ""
    @State private var converttempeture = ""
    let tempatures = ["celcius","fahreniet","kelvin"]
    
    var converedVallue :Double{
        var celciusTypeOfValue = 0.0
        
        if(tempature == "celcius"){
            celciusTypeOfValue = enteredValue
        }else if(tempature == "fahreniet"){
            celciusTypeOfValue = ((enteredValue-32.0) / 1.8)
        }else if(tempature == "kelvin"){
            celciusTypeOfValue = enteredValue - 273.0
        }
        
        if(converttempeture == "celcius"){
            return celciusTypeOfValue
        }else if(converttempeture == "fahreniet"){
            var aa = ((celciusTypeOfValue*1.8) + 32.0)
            return ((celciusTypeOfValue*1.8) + 32.0)
        }else if(converttempeture == "kelvin"){
            return celciusTypeOfValue + 273.0
        }
        
        
        
        return  0
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Enter the degree you wanted to convert"){
                    TextField("Degree",value: $enteredValue ,format : .number)
                    
                    Picker("Select the type you are convering", selection: $tempature){
                        ForEach(tempatures,id: \.self ){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Select the type you want to be converted"){
                    Picker("Select the type you are convering", selection: $converttempeture){
                        ForEach(tempatures,id: \.self ){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    
                    Text("\(converedVallue.formatted())")
                    
                }
                
                
            }
        }
    }
}

#Preview {
    ContentView()
}
