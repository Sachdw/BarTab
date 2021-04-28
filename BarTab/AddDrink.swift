//
//  Add_drink.swift
//  BarTab
//
//  Created by Sacha De Wilde on 4/19/21.
//



import SwiftUI
import FirebaseFirestore


//This View is the view that the user sees when they try to add a new drink not in the quicklist

struct AddDrink: View {
    
    @State var my_drink:String = ""
    @State private var isEditing = false
    @ObservedObject var data = getData()
    @EnvironmentObject var new_drink: NewDrinkInfo
    @Binding var rootIsActive : Bool
    
    
    
    var body: some View {
        
        VStack{
            Image("Topbar")
            Spacer()
            VStack{
                //Adding logo and text
                Image("Logo").padding(.top,30)
                Image("AddNewDrinkText")
                Image("WhatAreYouDrinking").padding(.top,20)
                Spacer()
                
                
                //Data input Box allows users to search from a database of drinks or enter their own drink
                HStack {
                    
                    CustomSearchBar(data: self.$data.datas, rootIsActive: self.$rootIsActive).padding(.top )
                    
                }.padding(.top,-100)
                Spacer()
            }
            
            //Link to search for liked drinks
            Image("SearchPrevious")
                .padding(.trailing,100)
                .padding(.bottom,20)
            
            //Navigation Bar
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



//Search bar which queries a database for drinks
struct CustomSearchBar : View {
    @State var txt = ""
    @Binding var data : [drinkType]
    @EnvironmentObject var new_drink: NewDrinkInfo
    @Binding var rootIsActive : Bool

    
    var body : some View{
        VStack(spacing: 0){
            
            HStack{
                
                TextField("Search", text: self.$txt)
                
                //If The user has entered something in the search bar
                if self.txt != ""{
                    
                    //Make a button to let the user save a drink name appear
                    NavigationLink(
                        destination: DrinkVessel(rootIsActiv: self.$rootIsActive),
                        label: {
                            Text("Next..")
                        })
                        //Checks that the correct drink name and properties are passed through
                        .simultaneousGesture(TapGesture().onEnded{
                                                if self.txt != new_drink.drink.name{
                                                    new_drink.drink.name=self.txt
                                                    new_drink.drink.alcohol_content=0.0
                                                    
                                                }})
                }
            }.padding()
            
            //If the user enters something in the text box
            if self.txt != ""{
                
                //If no results found, let the user know
                if  self.data.filter({$0.name.lowercased().contains(self.txt.lowercased())}).count == 0
                {
                    
                    Text("No Results Found").foregroundColor(Color.black.opacity(0.5)).padding()
                }
                
                //If results are found, display them
                else{
                    List(self.data.filter{$0.name.lowercased().contains(self.txt.lowercased())}){i in
                        Button(action: {
                            
                            new_drink.drink.alcohol_content = i.alcohol_content
                            new_drink.drink.name=i.name
                            new_drink.drink.type=i.type
                            self.txt = i.name
                        }, label: {
                            Text(i.name)
                        })
                        
                        
                    }
                }
            }
        }.background(Color.white)
        .padding()
    }
    
}


//Collect the data from Firestore to display suggestions under search bar
class getData : ObservableObject{
    
    @Published var datas = [drinkType]()
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("drinks").getDocuments { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                
                let id = i.documentID
                let name = i.get("name") as! String
                let type = i.get("type") as! String
                let alcohol_content =
                    i.get("alcohol content") as! String
                
                
                
                self.datas.append(drinkType(id: id,name: name, type: type,alcohol_content: Float(alcohol_content) ?? 0.0))
            }
        }
    }
    
}



struct Detail : View {
    @EnvironmentObject var new_drink: NewDrinkInfo
    
    var data : drinkType
    
    var body : some View{
        
        Text(new_drink.drink.name)
    }
}
