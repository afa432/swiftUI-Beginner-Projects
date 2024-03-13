//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ahmet Faruk Arvas on 22.02.2024.
//

import SwiftUI


struct ContentView: View {
    @State private var order = Order()

    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Select your cake type:" , selection: $order.type){
                        ForEach(Order.types.indices, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)",value: $order.quantity,
                            in: 3...20)
                }
                Section{
                    Toggle("Any special request ?", isOn: $order.specialRequestEnable)
                    
                    if(order.specialRequestEnable == true){
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra springles", isOn: $order.addSpringles)
                    }
                }
                Section{
                    NavigationLink("Delivery Details"){
                        AddressView(order: order)
                    }
                }
            }.navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
