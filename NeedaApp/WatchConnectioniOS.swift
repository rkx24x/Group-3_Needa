//
//  WatchConnectioniOS.swift
//  Needaapplication
//
//  Created by Alanoud on 04/09/1445 AH.
//

import UIKit
import WatchConnectivity
import CloudKit

class ViewController: UIViewController, WCSessionDelegate {
    
    //Error Handling
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WCSession activation failed with error: \(error.localizedDescription)")
            return
        }
        print("WCSession activated with state: \(activationState)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("WCSession did become inactive")
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("WCSession did deactivate. Reactivating...")
        session.activate() // Recommended to reactivate the session if it's been deactivated
    }
    
    
    
    //Session Activation "activate the WCSession in the viewDidLoad method "
    override func viewDidLoad() {
        super.viewDidLoad()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
        // Fetch and send user name to the watch after view did load
        fetchAndSendUserNameToWatch()
    }
    
    // Function to fetch user's name from CloudKit and send it to the Apple Watch
    func fetchAndSendUserNameToWatch() {
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        
        // Fetch user record from CloudKit
        if let userRecordName = UserDefaults.standard.string(forKey: "userRecordID") {
            let recordID = CKRecord.ID(recordName: userRecordName)
            privateDatabase.fetch(withRecordID: recordID) { /*[weak self]*/ record, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error fetching user record in the file WatchConnectioniOS.swift : \(error)")
                        return
                    }
                    if let record = record, let userName = record["FullName"] as? String {
                        self.sendUserNameToWatch(userName)
                    }
                }
            }
        }
    }
    
    
    // Send the user's name to the watch //not currently used
    private func sendUserNameToWatch(_ userName: String) {
        let session = WCSession.default
        if session.isReachable {
            let message = ["userName": userName]
            session.sendMessage(message, replyHandler: nil, errorHandler: { error in
                print("Error sending message to Apple Watch: \(error.localizedDescription)")
            })
        } else {
            print("Apple Watch is not reachable.")
        }
    }
    
}





