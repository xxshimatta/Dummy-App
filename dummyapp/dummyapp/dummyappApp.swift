//
//  dummyappApp.swift
//  dummyapp
//
//  Created by Jeffrey Clay Setiawan on 02/03/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application:UIApplication, didFinishLaunchingWithOptions
                     launchOptions:[UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("App is Starting Up.")
        FirebaseApp.configure()
        return true
    }
}


@main
struct dummyappApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var collectionViewModel = CollectionViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(collectionViewModel)
        }
    }
}
