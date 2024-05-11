import SwiftUI  // Import SwiftUI for building UI components
import MapKit  // Import MapKit for map functionalities
import CoreLocation  // Import CoreLocation for location services


struct IdentifiableLocation: Identifiable, Hashable {
    let id: String // Unique identifier for the location
    let location: CLLocation //object representing the geographical location
    
    
    // Equatable protocol conformance to compare locations
    static func == (lhs: IdentifiableLocation, rhs: IdentifiableLocation) -> Bool {
        return lhs.id == rhs.id && lhs.location.coordinate.latitude == rhs.location.coordinate.latitude && lhs.location.coordinate.longitude == rhs.location.coordinate.longitude
    }
    
    // Hash function to enable hashing of the object, used in collections like sets
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(location.coordinate.latitude)
        hasher.combine(location.coordinate.longitude)
    }
}




struct MapsView: View {
    @StateObject private var locationManager = LocationManager.shared // Shared location manager instance
    @State private var trackingMode: MapUserTrackingMode = .follow // Tracking mode for the map
    @State private var navigateToNextScreen = false // State to control navigation flow
    
    var location: IdentifiableLocation  // State to hold a single location
    @EnvironmentObject var viewModel: SharedViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // MapView that binds to the locationManager's region and trackingMode
                MapView(region: $locationManager.region, trackingMode: $trackingMode, location: location)
                    .navigationBarTitle("Needa Map", displayMode: .inline)
                Button("تم") {
                    viewModel.isActive = false
                    viewModel.selectedLocation = nil
                    navigateToNextScreen = true
                    print("moved")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .onAppear {
                print("Requesting location update...")
                
                locationManager.requestLocation()  // Request location update on appear
            }
            .navigationBarItems(trailing: NavigationLink(destination: NeedaHomePage(), isActive: $navigateToNextScreen) {
                EmptyView()
            })
        }
    }
}



struct MapView: View {
    @Binding var region: MKCoordinateRegion
    @Binding var trackingMode: MapUserTrackingMode
    var location: IdentifiableLocation  // A single identifiable location
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: [location]) { location in
            MapPin(coordinate: location.location.coordinate)  // Pin at the location
        }
    }
}
