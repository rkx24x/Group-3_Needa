//
//  NeedaWatchConnection.swift
//  NeedaWatch Watch App
//
//  Created by Alanoud on 04/09/1445 AH.
//
// NeedaWatchConnection.swift
import WatchConnectivity
import SwiftUI

class NeedaWatchConnection: NSObject, WCSessionDelegate, ObservableObject {
    @Published var receivedName: String = ""
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    // WCSessionDelegate methods:
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Handle activation completion
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // This is where the message is received from the iOS app
        DispatchQueue.main.async { [weak self] in
            if let name = message["userName"] as? String {
                self?.receivedName = name
            }
        }
    }
    
    // Add other delegate methods as needed...
}









/*
import Foundation
import WatchConnectivity
import WatchKit
class NeedaWatchConnection: NSObject, WKExtensionDelegate, WCSessionDelegate {
  
    func applicationDidFinishLaunching() {
        // Configure Watch Connectivity session
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    // MARK: - WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
           // Handle session activation completion
           if let error = error {
               print("WCSession activation failed with error: \(error.localizedDescription)")
               return
           }
           print("WCSession activated with state: \(activationState)")
       }
       
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let userName = message["userName"] as? String {
            print("Received user name from iOS app: \(userName)")
            // Do something with the user name on the Apple Watch
        }
    }
}

*/
