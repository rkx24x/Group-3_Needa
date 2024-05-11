//
//  NeedaWatchApp.swift
//  NeedaWatch Watch App
//
//  Created by Reham  on 10/09/1445 AH.
//

import SwiftUI
import WatchConnectivity
import CloudKit

@main
struct NeedaWatch_Watch_AppApp: App {
    @StateObject private var sessionManager = NeedaWatchConnection()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(sessionManager)
        }
    }
}
