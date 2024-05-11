
import SwiftUI
import CoreLocation
import CloudKit
import FirebaseFunctions


struct NeedaHomePage: View {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    // State variables to manage navigation to different views
    
    @State private var showingPatientMedicalHistory = false
    @State private var showingPatientHealthInfo = false
    @State private var showingPatientStatistics = false
    @State private var showAlert = false
    
    //to go to maps
    @EnvironmentObject var viewModel: SharedViewModel
    // State variables for navigation and role checking
    @State private var navigateToMaps = false
    @State private var isHealthPractitioner = false
    
    // State and environment variables for opening URLs and managing alerts
    @State private var goToAppStore = false
    @State private var showingAlert = false
    @Environment(\.openURL) var openURL
    // Delegates app lifecycle methods
    @ObservedObject var callerlocationManager = LocationManager.shared
    
    // State variable for alert messages when no health practitioner is near
    
    @State private var alertMessage: String? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor")
                    .ignoresSafeArea(.all)
                
                VStack { // Start of VStack
                    
                    HStack { // Start of top HStack for icons
                        
                        if isHealthPractitioner {
                            if let location = viewModel.selectedLocation {
                                VStack {
                                    Button("اذهب للخريطة") {
                                        navigateToMaps = true // Navigate to maps on button tap
                                    }
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    
                                    // Navigation link to MapsView
                                    NavigationLink(
                                        destination: MapsView(location: location),
                                        isActive: $navigateToMaps
                                    ) {
                                        EmptyView()
                                    }
                                }
                            } else {
                                Text("لا يوجد أي نداء")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, -40)
                                Spacer()
                            }
                        }
                        
                        Image("needasmall") // Icon for users or contacts
                            .resizable() // Make image resizable
                            .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                            .frame(width: 120, height: 120) // Set frame for image
                            .padding()
                        
                        
                        // End of needasmall Image
                        
                        
                    } // End of top HStack
                    .padding(.top, -30)
                    
                    Spacer() // Spacer to push content to top and bottom
                    
                    // Call button with alert on tap
                    
                    Button(action: {
                        showAlert = true
                        
                        
                    }) {
                        Text("نداء") // 'Call' button text
                            .font(.system(size: 80)) // Font for the button , 60
                            .foregroundColor(.white)
                            .frame(width: 230, height: 230) // Set frame for button , width: 190, height: 190
                            .background(Color("button")) // Set button color
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 4)
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                            .padding(.bottom, 50)
                    } // End of Call button
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("تأكيد النداء"),
                            message: Text("هل أنت متأكد أنك تريد إرسال نداء الحاجة؟"),
                            primaryButton: .destructive(Text("نعم")) {
                                FechCloseHP  { tokens in
                                    // Here 'tokens' is an array of tuples containing the record names and their corresponding tokens.
                                    if tokens.isEmpty {
                                        print("No nearby tokens received or error occurred.")
                                    } else {
                                        for token in tokens {
                                            print("Received token for \(token)")
                                        }
                                        sendNeedaWithRecord(tokens:tokens)
                                    }
                                }
                                
                            },
                            secondaryButton: .cancel(Text("إلغاء"))
                        )
                    }
                    
                    Spacer() // Spacer to push content to top and bottom
                    
                    HStack { // Start of bottom HStack for icons and text
                        
                        VStack { // Start of VStack for health information icon and text
                            Button(action: {
                                // Action to navigate to health information page
                                self.showingPatientHealthInfo = true
                            }) {
                                Image(systemName: "heart.text.square") // Icon for health information
                                    .foregroundColor(.white)
                                    .imageScale(.large)
                            }
                            Text("معلوماتي الصحية") // Text label for icon
                                .foregroundColor(.white)
                                .font(.caption)
                        } // End of VStack for health information icon and text
                        .fullScreenCover(isPresented: $showingPatientHealthInfo) {
                            newViewHealthInfoPage() // Show health info page on button tap
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                self.showingPatientMedicalHistory = true
                            }) {
                                Image(systemName: "book.closed")
                                    .foregroundColor(.white)
                                    .imageScale(.large)
                            }
                            Text("التاريخ الطبي")
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                        .fullScreenCover(isPresented: $showingPatientMedicalHistory) {
                            NewmedicalHistory() // Show medical history page on button tap
                        }
                        
                        
                        Spacer()
                        
                        
                    } // End of bottom HStack
                    
                    .frame(maxWidth: 330)
                    .padding()
                    .background(Color("button"))
                    .cornerRadius(20)
                    
                    
                    // Alert for errors or notifications
                    
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("عذرًا"), message: Text(alertMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                    }
                }// End of VStack
                .onAppear{
                    requestNotificationPermission() // Request notifications permission on appear
                    updateUserLocationIfNeeded() // Update user location if needed
                    checkIfHealthPractitioner { isPractitioner in
                        self.isHealthPractitioner = isPractitioner
                    }
                }
                
            }
            
        }
        
    }
    
    
    func FechCloseHP(completion: @escaping ([String]) -> Void) {
        var closeLocations: [String: CLLocation] = [:]
        var tokens: [String] = []
        
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        
        // Retrieve the stored user record ID
        if let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") {
            let userRecordID = CKRecord.ID(recordName: userRecordIDString)
            
            // Fetch and update the existing record
            privateDatabase.fetch(withRecordID: userRecordID) { record, error in
                if let error = error {
                    print("Error fetching user record: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                guard let userLocation = self.callerlocationManager.userLocation else {
                    print("User location not found.")
                    completion([])
                    return
                }
                
                let predicate = NSPredicate(value: true)
                let query = CKQuery(recordType: "HCP", predicate: predicate)
                
                privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
                    if let error = error {
                        print("CloudKit Query Error: \(error.localizedDescription)")
                        completion([])
                        return
                    }
                    
                    guard let records = records else {
                        print("No records found")
                        completion([])
                        return
                    }
                    
                    for record in records {
                        if let location = record["location"] as? CLLocation,
                           let reference = record["UserID"] as? CKRecord.Reference {
                            let recordName = reference.recordID.recordName
                            if recordName != userRecordIDString && userLocation.distance(from: location) <= 5000 {
                                closeLocations[recordName] = location
                            }
                        }
                    }
                    
                    if closeLocations.isEmpty {
                        print("No nearby locations found.")
                        DispatchQueue.main.async {
                            self.alertMessage = "لا يوجد ممارسين صحيين بالقرب منك"
                            self.showingAlert = true
                        }
                        completion([])
                        return
                    }
                    
                    // Fetch tokens for each close location
                    let group = DispatchGroup()
                    for (recordName, _) in closeLocations {
                        group.enter()
                        let recordID = CKRecord.ID(recordName: recordName)
                        privateDatabase.fetch(withRecordID: recordID) { (record, error) in
                            if let error = error {
                                print("Failed to fetch token for \(recordName): \(error.localizedDescription)")
                            } else if let record = record, let token = record["token"] as? String {
                                tokens.append(token)
                            } else {
                                print("Token not found for \(recordName)")
                            }
                            group.leave()
                        }
                    }
                    
                    group.notify(queue: .main) {
                        print("Tokens fetched for nearby locations: \(tokens)")
                        completion(tokens)
                    }
                }
            }
        } else {
            print("User record ID not found in UserDefaults.")
            completion([])
        }
        
        
        
    }
    
    
    func sendNeedaWithRecord(tokens:Array<Any>){
        var needaRecordName = ""
        var userLocation = self.callerlocationManager.userLocation
        
        
        // Check if the userRecordID is available
        guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") else {
            print("User record ID not found")
            return
        }
        
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        
        // Convert the userRecordIDString into a CKRecord.ID
        let userRecordID = CKRecord.ID(recordName: userRecordIDString)
        
        let needaRecord = CKRecord(recordType: "NeedaCall")
        
        // Set the surgery details
        needaRecord["UserLocation"] = userLocation
        
        // Create a CKRecord.Reference to link this needa record to the user's Individual record
        let reference = CKRecord.Reference(recordID: userRecordID, action: .deleteSelf)
        needaRecord["UserID"] = reference
        
        // Save the needa record
        privateDatabase.save(needaRecord) { _, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle any errors during save operation
                    print("CloudKit Save Error: \(error.localizedDescription)")
                    return
                } else {
                    needaRecordName = needaRecord.recordID.recordName
                    print ("needaRecordName: \(needaRecordName)")
                    print("save Needa done")
                    sendNeedaThroughServer(needaRecordName: needaRecordName, tokens: tokens)
                }
            }
        }
        
        
    }
    
    
    
    func sendNeedaThroughServer(needaRecordName: String, tokens:Array<Any>){
        print ("needaRecordName: \(needaRecordName)")
        
        let functions = Functions.functions()
        functions.httpsCallable("sendPushNotification").call([
            "tokens": tokens,
            "title": "هناك شخص يحتاج المساعدة",
            "body": "اضغط زر الموقع في الصفحة الرئيسيو لاستعراض الموقع",
            "needaRecordId": needaRecordName,
            
            //   "needaRecordId": needaRecordName
        ]) { result, error in
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                    print("Error:", code, message, details ?? "")
                }
            }
            if let response = result?.data as? [String: Any] {
                print("Received response:", response)
            }
        }
        
    }
    
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                // Handle success - for example, you might want to call a function to register for remote notifications.
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else if let error = error {
                // Handle errors here
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    private func updateUserLocationIfNeeded() {
        // Retrieve the user record ID from UserDefaults
        guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") else {
            print("User record ID not found.")
            return
        }
        
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        let userRecordID = CKRecord.ID(recordName: userRecordIDString)
        
        // Fetch the user record from CloudKit
        privateDatabase.fetch(withRecordID: userRecordID) { record, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to fetch user record: \(error.localizedDescription)")
                    return
                }
                
                guard let record = record, let userType = record["UserType"] as? String else {
                    print("Failed to retrieve UserType from user record.")
                    return
                }
                
                // Check if the user is a healthcare practitioner
                if userType == "healthcarePractitioner" {
                    self.updateLocationForHCP(userRecordID: userRecordID)
                } else {
                    print("User is not a healthcare practitioner.")
                }
            }
        }
    }
    
    
    private func checkIfHealthPractitioner(completion: @escaping (Bool) -> Void) {
        // Retrieve the user record ID from UserDefaults
        guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") else {
            print("User record ID not found.")
            completion(false)
            return
        }
        
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        let userRecordID = CKRecord.ID(recordName: userRecordIDString)
        
        // Fetch the user record from CloudKit
        privateDatabase.fetch(withRecordID: userRecordID) { record, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to fetch user record: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let record = record, let userType = record["UserType"] as? String else {
                    print("Failed to retrieve UserType from user record.")
                    completion(false)
                    return
                }
                
                // Check if the user is a healthcare practitioner
                if userType == "healthcarePractitioner" {
                    completion(true)
                } else {
                    print("User is not a healthcare practitioner.")
                    completion(false)
                }
            }
        }
    }
    
    
    private func updateLocationForHCP(userRecordID: CKRecord.ID) {
        
        guard let userLocation = self.callerlocationManager.userLocation else {
            print("User location not found.")
            return
        }
        
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        
        // Create or fetch the healthcare record linked to this user
        let healthcareRecordID = CKRecord.ID(recordName: UserDefaults.standard.string(forKey: "userRecordIDhcp") ?? "")
        
        privateDatabase.fetch(withRecordID: healthcareRecordID) { record, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to fetch healthcare record: \(error.localizedDescription)")
                    return
                }
                
                let healthcareRecord = record ?? CKRecord(recordType: "HCP", recordID: healthcareRecordID)
                healthcareRecord["location"] = userLocation
                
                // Save the updated healthcare record to CloudKit
                privateDatabase.save(healthcareRecord) { _, error in
                    if let error = error {
                        print("Failed to update location in CloudKit: \(error.localizedDescription)")
                    } else {
                        print("Location updated successfully for healthcare practitioner.")
                    }
                }
            }
        }
    }
    
} //end of the struct NeedaHomePage




#Preview {
    
    NeedaHomePage()
}
