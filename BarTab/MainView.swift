//
//  MainView.swift
//  BarTab
//
//  Created by Sacha De Wilde on 4/19/21.
//

//This is the view for the main screen that the user sees

import SwiftUI

struct MainView: View{
    @State private var menuOpened = false
    @State var drinkCount = 0
    @EnvironmentObject var info : DrinkManagement
    @EnvironmentObject var pages : Pages
    
    @State var isActive : Bool = false
    
    var body: some View{
        
        //Defining the add drink button as a variable so it can be hidden when the Quick menu is open
        let new_drink = Image("Add new drink")
        
        //Main Z Stack places background at bottom
        ZStack()
        {
            Image("Background")
            
            //Main Content area
            Image("Main box")
                .padding(.bottom, 55.0)
            VStack()
            {
                Spacer()
                Image("Logo")
                    .padding(.top, 80.0)
                Image("Bar Tab")
                    .padding(.top, 5.0)
                Spacer()
                
                
                //H Stack lists the quicklist and add buttons
                HStack(){
                    Spacer()
                    //Only Show the quick list button if the list is closed
                    if !menuOpened {
                        Button(action:{
                            
                            //Open the Quick Menu
                            pages.page = 1
                            self.menuOpened.toggle()
                        },
                        label:
                            {
                                Image("QuickList")
                                    .padding(.trailing, 170.0)
                            })
                    }
                    
                    Spacer()
                    
                    if !menuOpened{
                        NavigationLink(
                                        destination: AddDrink(rootIsActive: self.$isActive),
                                        isActive: self.$isActive
                                    ) {
                                        new_drink
                                    }
                                    
                    }
                        
                        //NavigationLink(
                        //destination: AddDrink(),
                        //label:{new_drink})}
                    
                    Spacer()
                }
                
                
                
                
                //Text Area Displaying info about today's drink consumption
                Text("Today's Drinks: " + String(info.todayCount))
                    .font(Font.custom("OpenSans-Regular",size:16))
                Text("Total Money Spent: $" + String(info.todayMoney))
                    .font(Font.custom("OpenSans-Regular",size:16))
                Text("Estimated Calories: " + String(info.todayCal))
                    .font(Font.custom("OpenSans-Regular",size:16))
                Spacer()
                
                
                //Navigation bar
                ZStack(){
                    Image("Navigation Bar")
                        .padding(.bottom, 40.0)
                    HStack(){
                        Spacer()
                        Image("Home Icon")
                        Spacer()
                        Image("Calendar Icon")
                        Spacer()
                        Image("Stats Icon")
                        Spacer()
                    }
                    .padding(.bottom, 55.0)
                }
            }
            QuickMenu(width: 400,
                      //UIScreen.main.bounds.width/1.8
                      menuOpened: menuOpened,
                      toggleMenu: toggleMenu)
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
    }
    func toggleMenu() {
        menuOpened.toggle()
    }
}
   



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


