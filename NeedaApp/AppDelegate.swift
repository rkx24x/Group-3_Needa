import UIKit  // Import UIKit for managing user interface elements in iOS apps
import UserNotifications  // Import UserNotifications framework for handling local and remote notifications
import CloudKit  // Import CloudKit for interacting with iCloud
import FirebaseCore  // Import FirebaseCore for Firebase configuration
import FirebaseMessaging  // Import FirebaseMessaging for handling messaging
import Firebase  // Import Firebase for additional Firebase functionalities

class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate, ObservableObject {
    var window: UIWindow? // Main window for the app
    var sharedViewModel = SharedViewModel()  // Shared view model instance
    static var userIsRegistered = false // Static variable to track user registration status
    static var pendingFCMToken = "hi rub"
    static let shared = AppDelegate()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure() // Configure Firebase on app launch
        
        // Set up messaging delegate and notification center.
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        // Now you should manually register for remote notifications since auto-swizzling is disabled.
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token from system: \(token)")
        
        // Send this system token to Firebase to get the corresponding Firebase token.
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let token = fcmToken else { return }
        print("Token from firebace: \(token)")
        AppDelegate.pendingFCMToken = token
        print("Token from firebace222: \(AppDelegate.pendingFCMToken)")
        
        if(AppDelegate.userIsRegistered){
            updateTokenIfNeeded()
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("Message received in foreground: \(userInfo)")
        if let needaRecordId = userInfo["needaRecordId"] as? String {
            // Here you have access to needaRecordId
            print("needaRecordId: \(needaRecordId)")
            fetchLocation(for: needaRecordId)
            
        }
        
        // Customize how the notification is presented, for example, as a banner and with sound
        completionHandler([[.banner, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("User interacted with notification: \(userInfo)")
        
        if let needaRecordId = userInfo["needaRecordId"] as? String {
            // Here you have access to needaRecordId
            print("needaRecordId: \(needaRecordId)")
        }
        
        // Handle the user interaction with the notification
        completionHandler()
    }
    
    
    
    
    func updateTokenIfNeeded(){
        print("printing token \(AppDelegate.pendingFCMToken)")
   
        if let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") {
            updateTokenInCloudKit(token: AppDelegate.pendingFCMToken, userRecordIDString: userRecordIDString)
        }
        
        else {
            print ("no user id")
        }
    }
    
    
    func updateTokenInCloudKit(token: String, userRecordIDString: String) {
        print(" hello Token from firebace: \(token)")
        
        let userRecordID = CKRecord.ID(recordName: userRecordIDString)
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        
        privateDatabase.fetch(withRecordID: userRecordID) { record, error in
            guard let record = record, error == nil else {
                print("Error fetching user record: \(String(describing: error?.localizedDescription))")
                return
            }
            
            record["token"] = token
            
            privateDatabase.save(record) { _, error in
                if let error = error {
                    print("Error saving token to CloudKit: \(error.localizedDescription)")
                } else {
                    print("Token updated in CloudKit successfully for the existing user.")
                    AppDelegate.userIsRegistered = true
                }
            }
        }
    }
    
    
    
    func fetchLocation(for needaRecordId: String) {
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        
        // Create a CKRecord.ID using the needaRecordId
        let recordID = CKRecord.ID(recordName: needaRecordId)
        
        // Fetch the CKRecord corresponding to the given record ID
        privateDatabase.fetch(withRecordID: recordID) { record, error in
            if let error = error {
                // Handle the error
                print("Error fetching record with ID \(needaRecordId): \(error.localizedDescription)")
                return
            }
            guard let record = record else {
                
                print("Record not found for ID \(needaRecordId)")
                return
            }
            
            // Access the location attribute from the fetched record
            if let location = record["UserLocation"] as? CLLocation {
                
                print("Location associated with needaRecordId \(needaRecordId): \(location)")
         
                DispatchQueue.main.async {
                    // Create an IdentifiableLocation to pass to MapsView
                    let identifiableLocation = IdentifiableLocation(id: needaRecordId, location: location)
                    self.sharedViewModel.selectedLocation = identifiableLocation
                    self.sharedViewModel.isActive = true
                }
                
            } else {
                print("UserLocation attribute not found or is not a CLLocation")
                
            }
            
        }
    }
    
    
    
    
}


