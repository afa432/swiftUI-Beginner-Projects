//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ahmet Faruk Arvas on 25.02.2024.
//

import Foundation

@Observable
class Order: Codable{
    
    enum CodingKeys: String,CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnable = "specialRequestEnable"
        case _extraFrosting = "extraFrosting"
        case _addSpringles = "addSpringles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnable = false{
        didSet{
            if specialRequestEnable == false{
                extraFrosting = false
                addSpringles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSpringles = false
    
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var ValidAddress: Bool{
        if name.isEmpty  || streetAddress.isEmpty  || city.isEmpty  || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // 2$ per cake
        var cost = Decimal(quantity) * 2
        //  complicated cakes cost more
        cost += Decimal((type/2)*quantity)

        // 1$ for frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        // 0.5$ for springles
        if addSpringles {
            cost += Decimal(quantity)/2
        }
        return cost
    }
}
