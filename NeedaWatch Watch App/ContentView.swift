//
//  ContentView.swift
//  NeedaWatch Watch App
//
//  Created by Alanoud on 01/09/1445 AH.
//

import SwiftUI
import WatchKit
import WatchConnectivity

struct ContentView: View {
    @State private var name: String = ""
    @ObservedObject var sessionManager = NeedaWatchConnection()
    
    var body: some View {
        
        
        ZStack{
            Color("backgroundColor")
                .ignoresSafeArea(.all)
            
            VStack {
                
                HStack {
//                    Text(" \(sessionManager.receivedName)")
//                        .foregroundColor(Color("button"))
                    Image("needasmall")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50) // Adjust the size as needed
                    
                }   .padding(.bottom,70)
                
//                Button(action: { // Start of Call button
//                    // Action for the button
//                    
//                }) {
//                    Text("نداء") // 'Call' button text
//                        .font(.system(size: 70)) // Font for the button , 70
//                        .foregroundColor(.white)
//                        .frame(width: 130, height: 130)
//                        .background(Color("button")) // Set button color
//                        .clipShape(Circle())
//                        .overlay(
//                            Circle()
//                                .stroke(Color.white, lineWidth: 4)
//                        )
//                        .shadow(color: Color.red.opacity(0.5), radius: 10, x: 0, y: 5)
//                        .padding(.bottom, 50)
//                }
                
            }
        }
    }
    
   /*
    private func fetchData() {
        // Replace the API URL with your actual backend API endpoint
        let apiUrl = URL(string: "https://yourapi.com/your-endpoint")!
        
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(UserData.self, from: data)
                    DispatchQueue.main.async {
                        self.name = result.name
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    } */
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}


/*
struct UserData: Codable {
    let name: String
}
*/
