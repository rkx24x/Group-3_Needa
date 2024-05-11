//
//import CoreLocation
//import CloudKit
//import MapKit
//
//class LocationManager: NSObject, ObservableObject{
//    
//    var locationUpdateCallback: ((CLLocation) -> Void)?
//    private let manager=CLLocationManager()
//    
//    @Published var userLocation: CLLocation?
//    static let shared = LocationManager()
//    
//    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 1000, longitudinalMeters: 1000)
//    
//    
//    override init(){
//        super.init()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.startUpdatingLocation()
//        
//    }
//    
//    func requestLocation(){
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//    }
//    
//    
//}
//
//extension LocationManager: CLLocationManagerDelegate {
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse || status == .authorizedAlways {
//            manager.startUpdatingLocation()
//        }
//        switch status {
//            
//        case .notDetermined:
//            print("DEBUG: Not determined")
//        case .restricted:
//            print("DEBUG: Restricted")
//        case .denied:
//            print("DEBUG: Denied")
//        case .authorizedAlways:
//            print("DEBUG: Auth always")
//        case .authorizedWhenInUse:
//            print("DEBUG: Auth when in use")
//            
//        @unknown default:
//            break
//        }
//    }
//    
//    
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//         guard let location = locations.last else { return }
//         self.userLocation = location
//        
//        DispatchQueue.main.async {
//            self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
//        }
//        
//         if let callback = locationUpdateCallback {
//             callback(location)
//         }
//         
//         print("Location updated: \(location.coordinate.latitude), \(location.coordinate.longitude)")
//     }
// 
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to find user's location: \(error.localizedDescription)")
//    }
//    
//
//    
//    
////    public func saveLocationToCloudKit(location: CLLocation) {
////               guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") else {
////                   print("User record ID not found.")
////                   return
////               }
////               
////               let container = CKContainer(identifier: "iCloud.NeedaDB")
////               let privateDatabase = container.privateCloudDatabase
////               let userRecordID = CKRecord.ID(recordName: userRecordIDString)
////               
////               let healthcare = CKRecord(recordType: "HCP")
////               healthcare["location"] = location
////               
////               let reference = CKRecord.Reference(recordID: userRecordID, action: .deleteSelf)
////               healthcare["UserID"] = reference
////               
////               privateDatabase.save(healthcare) { record, error in
////                   DispatchQueue.main.async {
////                       if let error = error {
////                           print("CloudKit Save Error: \(error.localizedDescription)")
////                       } else {
////                           print("Location saved to CloudKit.")
////                       }
////                   }
////               }
////           }
//    
//    }
//    
//    
//
