//
//  File.swift
//  BarTab
//
//  Created by Sacha De Wilde on 4/22/21.
//

import Foundation

class Pages: ObservableObject{
    @Published var page = 0
}

//Observable object which allows us to pass data for new drinks between different views of the app. We will subscribe to this in the other views with the @EnvironmentObject property
class NewDrinkInfo: ObservableObject{
    @Published var drink = drinkType()    
}

//Main Data for today's number of drinks, money spent, and calories consumed. Displayed on main page
class DrinkManagement: ObservableObject{
    @Published var todayCount:Int = 0
    @Published var todayMoney:Float = 0.0
    @Published var todayCal:Int = 0
}



//A Structure which allows us to store information about new drinks through the add drink functionality
struct drinkType : Identifiable {
    
    var id : String
    var name : String
    var type : String
    var size : Int
    var alcohol_content : Float
    var price : Float
    var bottle_size : Int
    var can_size : Int
    var big_bottle : Int
    var small_bottle : Int
    
    init(id: String? = nil, name: String? = nil, type: String? = nil, size: Int? = nil,  alcohol_content:Float? = nil, price:Float? = nil, bottle_size:Int? = nil, can_size:Int? = nil, big_bottle:Int? = nil, small_bottle:Int? = nil) {
        self.id = id ?? ""
        self.name = name ?? ""
        
        self.type = type ?? ""
        self.size = size ?? 0
        self.alcohol_content = alcohol_content ?? 0.0
        self.price = price ?? 0.0
        
        self.bottle_size = bottle_size ?? 0
        self.can_size = can_size ?? 0
        self.big_bottle = big_bottle ?? 0
        self.small_bottle = small_bottle ?? 0


    }
    
}

//List of data to be stored in Quicklist
class QuickListInfo: ObservableObject{
    @Published var listData:[MenuItem] = [
        MenuItem(text: "Carlton Dr..",imageName: "beer",price: "5.00"),
        MenuItem(text: "Smirno..",imageName: "Vodka Bottle",price: "5.00"),
        MenuItem(text: "Jack and..",imageName: "Whisky",price: "5.00"),
        MenuItem(text: "Coopers Pa..",imageName: "Beer Bottle",price: "5.00"),
        MenuItem(text: "Campari",imageName: "Shot Glass",price: "5.00"),
        MenuItem(text: "Singha",imageName: "Beer Bottle",price: "5.00"),
        
    ]

}


//Structure for menu items
struct MenuItem: Identifiable{
    var id = UUID()
    var text : String
    let imageName: String
    // let alcohol_content: Float
    // let size: Float
    // let saved: Bool
    let price: String
    let handler: () -> Void = {
        print("Tapped item")
    }
}
