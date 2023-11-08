//
//  ContentView.swift
//  BetterRest
//
//  Created by Ahmet Faruk Arvas on 3.11.2023.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var sleepAmount = 4.0
    @State private var wakeUp   = Time
    @State private var coffeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMesage = ""
    @State private var showingAlert = false
    
    
    
    
    static var Time :Date{
        var components = DateComponents()
            
        components.hour = 7
        components.minute = 0
        
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    
    var body: some View {
        NavigationStack{
            Form{
                
                VStack(alignment: .leading, spacing: 0){
                    Text("When do you want to wake up")
                        .font(.headline)
                    
                    DatePicker("Please enter a time",selection: $wakeUp, displayedComponents:
                            .hourAndMinute).labelsHidden()
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("How much do you want to sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours ",value: $sleepAmount, in: 4...12,step: 0.25)
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("Daily coffe intake")
                        .font(.headline)
                    Picker("Daily coffe intake", selection: $coffeAmount){
                        ForEach(1..<12) { number in
                        Text(number == 1 ? "1 cup" : "\(number) cups")
                        }
                    }.labelsHidden()

                }
                
                
                
            }
            .navigationTitle("BetterRest")
            .toolbar{
                Button("Calculate" , action: calculateBedTime)
            }.alert(alertTitle, isPresented: $showingAlert){
                Button("Okey"){}
            } message: {
                Text(alertMesage)
            }
        }
    }
    
    func calculateBedTime(){
        do{
            let config = MLModelConfiguration()
            let model  = try SleepCalculator(configuration: config)
            
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            
            let hour = (components.hour ?? 0 ) * 60 * 60
            let minute = ( (components.minute ?? 0) * 60)
            
            
            let prediction =  try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount ,
                coffee: Double(coffeAmount)
            )
            
            let sleepTime = wakeUp - prediction.actualSleep

            alertTitle = "Your Sleep Time is..."
            alertMesage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Eror"
            alertMesage = "Sory There Was a Mistake"
        }
        showingAlert = true
        
    }
}

#Preview {
    ContentView()
}
