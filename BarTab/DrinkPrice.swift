//
//  DrinkPrice.swift
//  BarTab
//
//  Created by Sacha De Wilde on 4/23/21.
//

import SwiftUI
import Combine

struct DrinkPrice: View {
    
    @EnvironmentObject var new_drink: NewDrinkInfo
    @EnvironmentObject var info : DrinkManagement
    @EnvironmentObject var pages : Pages
    @State var stepperValue: Float = 0.0
    @State private var isEditing = false
    
    @Binding var shouldPopToRootView : Bool
    
    @State var isActive : Bool = false
    
    
    var body: some View {
        
        if pages.page == 0{
        VStack{
            Image("Topbar")
            Spacer()
            VStack{
                
                //Adding logo and text
                Image("Logo").padding(.top,30)
                Image("AddNewDrinkText")
                //Drink Name info
                Text("Your Drink: "+String(new_drink.drink.name)).font(Font.custom("OpenSans-Regular",size:16)).padding()
                //Drink Size Info
                Text("Drink Size: "+String(new_drink.drink.size)).font(Font.custom("OpenSans-Regular",size:16)).padding()
                //Alcohol Content info
                HStack{
                    Text("Alcohol Percentage: "+String(new_drink.drink.alcohol_content)+"%")
                    //Takes user to another screen to edit
                    NavigationLink(destination: EditAlc(), label: {Text("Edit")})
                }.padding()
                
                //Price info
                HStack{
                    Text("Price: $"+String(new_drink.drink.price))
                    //Takes user to another screen to edit
                    NavigationLink(destination: EditPrice(), label: {Text("Edit")})
                    
                }.padding()
                
                //Display the Drink type
                HStack{
                    Text("Drink Type: "+new_drink.drink.type)
                    
                    //Allow the user to edit the drink type
                    Menu(content: {
                        Button("Beer", action: {setType(drinkType:"Beer")})
                        Button("Light Beer", action: {setType(drinkType:"Light Beer")})
                        Button("Gin", action: {setType(drinkType:"Gin")})
                        Button("Vodka", action: {setType(drinkType:"Vodka")})
                        Button("Whiskey", action: {setType(drinkType:"Whiskey")})
                        Button("Rum", action: {setType(drinkType:"Rum")})
                        Button("Tequila", action: {setType(drinkType:"Tequila")})
                        Button("Brandy", action: {setType(drinkType:"Brandy")})
                        Button("Cognac", action: {new_drink.drink.type = "Cognac"})
                        Button("Liqueur", action: {new_drink.drink.type = "Liqueur"})
                        
                    }, label: {Text("Edit")})
                    
                }.padding()
                
                Spacer()
                
                Button("Add Drink", action: {info.todayCount += 1;
                        info.todayMoney += new_drink.drink.price;
                        info.todayCal += Int(round((Float(new_drink.drink.size)*(new_drink.drink.alcohol_content/100)*7)));
                        new_drink.drink = drinkType()
                        pages.page = 1
                        self.shouldPopToRootView = false
                        pages.page = 0
                        })

                Spacer()
                
                
                
            }
            
            
            
        }
        
        
        }else
        {
        MainView()
        
        }
        
    }
    func setType(drinkType:String){
        new_drink.drink.type = drinkType
        
    }
    
}







struct EditAlc : View {
    
    @EnvironmentObject var new_drink: NewDrinkInfo
    @State var stepperValue: Float = 4.0
    @State private var isEditing = false
    
    
    var body : some View{
        
        Stepper("Alcohol Percentage: \(stepperValue, specifier: "%.2f")", value: $stepperValue, in: 0...100, step: 0.1)
        Slider(value: $stepperValue, in: 0...90,step:1,
               onEditingChanged: { editing in
                isEditing = editing
                new_drink.drink.alcohol_content = stepperValue
                
               }
        )
        
    }
}




struct EditPrice : View {
    
    @EnvironmentObject var new_drink: NewDrinkInfo
    @State var stepperValue: Float = 5.0
    @State private var isEditing = false
    
    
    var body : some View{
        
        Stepper("Price: $\(stepperValue, specifier: "%.2f")", value: $stepperValue, in: 0...100, step: 0.05)
        Slider(value: $stepperValue, in: 0...90,step:1,
               onEditingChanged: { editing in
                isEditing = editing
                new_drink.drink.price = stepperValue
                
               }
        )
        
    }
}


