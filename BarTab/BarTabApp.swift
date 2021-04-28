//
//  BarTabApp.swift
//  BarTab
//
//  Created by Sacha De Wilde on 4/18/21.
//

import SwiftUI
import Firebase

@main
struct BarTabApp: App {
    @StateObject var drink = NewDrinkInfo()
    @StateObject var quickList = QuickListInfo()
    @StateObject var mainInfo = DrinkManagement()
    @StateObject var pages = Pages()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(drink)
                .environmentObject(quickList)
                .environmentObject(mainInfo)
                .environmentObject(pages)
        }
    }
}

//Establish connection to firebase database
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
