//
//  SwiftUIView.swift
//  BarTab
//
//  Created by Sacha De Wilde on 4/20/21.
//

import SwiftUI
import Combine

struct DrinkVessel: View {
    @State private var drinkVol:String = ""
    @State private var showCustom = false
    @EnvironmentObject var new_drink: NewDrinkInfo
    @Binding var rootIsActiv : Bool
    
    
    var body: some View {
        VStack{
            
            HStack{
            }
            //Adds the gradient bar to the top of the screen
            Image("Topbar")
            Spacer()
            VStack{
                
                //Adding logo and text
                Image("Logo").padding(.top,30)
                Image("AddNewDrinkText")
                Text("Your Drink: " + new_drink.drink.name).font(Font.custom("OpenSans-Regular",size:14))
                Image("DrinkVesselText").padding(.top,20)
                Spacer()
                HStack{
                    
                    //Menu of different 'can' sizes, activated when the 'can' button is pressed.
                    VStack{
                        Menu(content: {
                            Button("375ml Can", action: {drinkVol = getVol(volume:375)})
                            Button("355ml Can", action: {drinkVol = getVol(volume:355)})
                            Button("Custom Can", action: {showCustom = true})
                        }, label: {Image("Can Button")})
                        Image("Can")
                    }
                    
                    
                    //Menu of different bottle sizes activated when the bottle button is pressed
                    VStack{
                        Menu(content: {
                            Button("375ml", action: {drinkVol = getVol(volume:375)})
                            Button("575ml", action: {drinkVol = getVol(volume:575)})
                            Button("Custom Bottle..", action: {showCustom = true})
                        }, label: {Image("Bottle Button")})
                        Image("Bottle")
                    }
                    .padding(.leading,30)
                    
                    //Menu of different sizes of glasses, activated when the glass/cup button is pressed.
                    
                    VStack{
                        Menu(content: {
                            Button("Pint Glass", action: {drinkVol = getVol(volume:570)})
                            Button("Schooner", action: {drinkVol = getVol(volume:425)})
                            Button("Shot Glass", action: {drinkVol = getVol(volume:30)})
                            Button("Double Shot Glass", action: {drinkVol = getVol(volume:60)})
                            Button("Plastic Cup", action: {drinkVol = getVol(volume:300)})
                            Button("Custom Glass..", action: {showCustom = true})
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }, label: {Image("Glass Button")})
                        Image("Cup")
                    }.padding(.leading,30)
                }.padding(.bottom,150)
                
                //If a user wishes to enter a custom size, present them with a text box that only accepts an integer.
                
                if showCustom == true{
                    Spacer()
                    Text("Enter your drink size in mls: ")
                        .padding(.bottom, 20.0)
                        .font(Font.custom("OpenSans-Regular",size:14))
                    CustomSize().padding(.bottom,30)
                    Spacer()
                }
                //Display the Drink size
                if new_drink.drink.size != 0
                {
                    Text("Drink Size:  "+String(new_drink.drink.size)+" mls")
                        .font(Font.custom("OpenSans-Regular",size:14))
                    
                }
                if new_drink.drink.size != 0
                {
                    NavigationLink(
                        destination: DrinkPrice(shouldPopToRootView:self.$rootIsActiv),
                        label: {
                            Text("Next..")
                        })
                }
                
                
                //Navigation bar at bottom of screen
                
                ZStack()
                {
                    Image("Navigation Bar-2")
                        .padding(.bottom, 10.0)
                    Spacer()
                    HStack(){
                        Spacer()
                        //Navigation buttons at the bottom of page
                        NavigationLink(
                            destination: MainView(),
                            label: {Image("Home Icon")})
                        Spacer()
                        Image("Calendar Icon")
                        Spacer()
                        Image("Stats Icon")
                        Spacer()
                    }
                }
                
            }
        }
        
        
        
    }
    func getVol(volume: Int) -> String{
        showCustom = false
        new_drink.drink.size = volume
        return "Drink Size: "+String(new_drink.drink.size)+"mls"
    }
    
}





struct PressActions: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}


extension View {
    func pressAction(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(PressActions(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}



//Text box which only accepts numbers. Appears when the user wishes to enter a custom size.
struct CustomSize: View {
    @State var size = ""
    @EnvironmentObject var new_drink: NewDrinkInfo
    
    var body: some View {
        HStack{
            TextField("Enter custom size in mls", text: $size)
                .keyboardType(.numberPad)
                .onReceive(Just(size)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.size = filtered
                    }
                }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .frame(width: 220.0)
                .font(Font.custom("OpenSans-Regular",size:14))
            
            if self.size != ""{
                
                //Make a button to let the user save a drink size appear
                Button(action: {new_drink.drink.size = Int(self.size)!}, label: {Text("Enter")})
                    .padding()
            }
            
        }
    }
}
