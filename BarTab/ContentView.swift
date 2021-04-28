//
//  ContentView.swift
//  BarTab
//
//  Created by Sacha De Wilde on 4/18/21.
//

//Main ContentView and Navigation Viewing controller

import SwiftUI

struct ContentView: View
{
    var body: some View
    {
        NavigationView
        {
            VStack{
                MainView()
                    .navigationBarBackButtonHidden(true)
                
            }.offset(y:-48)
            .accentColor(Color(.label))
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



