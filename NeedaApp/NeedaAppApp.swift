//
//  NeedaAppApp.swift
//  NeedaApp
//
//  Created by shouq on 17/08/1445 AH.
//

import SwiftUI

@main
struct NeedaAppApp: App {
    
    // Link the custom AppDelegate with SwiftUI.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate.sharedViewModel)
        }
    }
    
}
