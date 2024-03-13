//
//  RaringView.swift
//  Bookworm
//
//  Created by Ahmet Faruk Arvas on 3.03.2024.
//

import SwiftUI

struct RaringView: View {
    @Binding var rating: Int
    var label = ""
    var maxRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor  = Color.yellow
    
    var body: some View {
        HStack{
            ForEach(1..<maxRating+1, id: \.self){number in
                Button{
                    rating = number
                }label: {
                    image(for: rating)
                        .foregroundStyle(number > rating ? offColor:onColor )
                }
            }
        }.buttonStyle(.plain)
    }
    func image(for number: Int) -> Image {
        if number > rating{
             return offImage ?? onImage
        }else{
            return onImage
        }
    }
}

#Preview {
    RaringView(rating: .constant(3))
}
