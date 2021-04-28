//
//  QuickMenu.swift
//  BarTab
//
//  Created by Sacha De Wilde on 4/19/21.
//


//This file describes the Quick Menu feature that is displayed on the mainscreen

import SwiftUI

//Structure of the Quick Menu
struct QuickMenu: View{
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    
    @EnvironmentObject var quickList : QuickListInfo
    
    var body: some View{
        ZStack(){
            
            //Dims the background while the quick menu is open
            GeometryReader{ _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.55))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture(){
                self.toggleMenu()
            }
            
            //Displays the menu content
            HStack(){
                MenuContent(items:quickList.listData)
                    .frame(width: width)
                    .offset(x: menuOpened ? 0:-width)
                    .animation(.default)
                
                Spacer()
            }
        }
    }
}



//Structure to display menu items in the quick menu
struct MenuContent: View{
    
    var items:[MenuItem]
    
    var body: some View{
        ZStack(){
            Color(UIColor(red: 142/255.0, green: 188.0/255, blue: 178/255.0, alpha: 0.55))
            
            VStack(alignment: .leading, spacing: 0)
            {
                Spacer()
                ForEach(items) {item in
                    HStack{
                        Button(action:{
                            print("Hi")
                        }, label: {
                            ZStack{
                                Image(item.imageName)
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height:60, alignment: .center)
                                Image("Add Drink")
                                    //.resizable()
                                    .padding(.top,20)
                                    .padding(.leading,20)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:30, height:30, alignment: .center)
                            }
                        })
                        
                        
                        
                        
                        Text(item.text)
                            .foregroundColor(Color.black)
                            .bold()
                            .font(.system(size:22))
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        Text("\t\t$"+item.price).multilineTextAlignment(.trailing)
                        
                    }
                    .padding(EdgeInsets(top: 10, leading: 120, bottom: 20, trailing: 0))
                    //Spacer()
                    Divider()
                }
                VStack(){
                    
                    Text("Edit Your QuickList").italic()
                    Image("Edit List")
                }.padding(.leading, 130.0)
                .padding(.top,20)
                Spacer()
                
                
            }.padding(.top,-170)
            
            
        }
    }
    
}





