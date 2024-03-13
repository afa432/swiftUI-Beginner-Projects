//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Ahmet Faruk Arvas on 26.02.2024.
//

import SwiftUI

struct CheckoutView: View {
    var order : Order
    
    @State private var confirmationMessage = ""
    @State private var showinginformation = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }.frame(height: 233)
                Text("Your Total cost is \(order.cost, format: .currency(code: "USD"))")
                
                Button("Place Order"){
                    Task{
                        await PlaceOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!",   isPresented: $showinginformation){
            Button("Ok") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    func PlaceOrder() async{
        guard let encoded = try? JSONEncoder().encode(order) else{
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased())x cupcakes is on its way"
            showinginformation = true
        }catch{
            print("Checkout Failed: \(error.localizedDescription)")
        }
    }
    
    
}

#Preview {
    CheckoutView(order: Order())
}
