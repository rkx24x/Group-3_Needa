//
//  ContentView.swift
//  NeedaApp
//
//  Created by shouq on 17/08/1445 AH.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var showingPatientRegistration = false  // State to track visibility of the patient registration page
    @State private var showingPractitionerRegistration = false  // State to track visibility of the practitioner registration page
    @State private var showingotp = false  // State to track visibility of the OTP page (currently unused)
    @State private var showingmap = false  // State to track visibility of the map (currently unused)
    
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack{
            
            ZStack {
                
                Color("backgroundColor")
                    .ignoresSafeArea(.all)
                
                //logo config
                Image("needa")
                    .resizable()
                    .frame(width:330, height:400)
                    .offset(x:0, y:-160)
                //---------------------------------------------
                
                // this code is when user cliks on the button it will move him to the intended page
                Button(action: {
                    self.showingPatientRegistration = true
                }) {
                    Text("تسجيل الدخول كمستخدم")
                        .frame( maxWidth: 350, minHeight: 50)
                        .background(Color("button"))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .padding(.horizontal)
                }.padding(.top, 390)
                    .onAppear { // Use onAppear to load the name when the view appears
                        nameValueUpdate()}
                    .fullScreenCover(isPresented: $showingPatientRegistration) {
                        patientRegestrationPage()  // Presents the patient registration page when the button is tapped
                    }
                
                
                // Button for practitioner registration
                Button(action: {
                    self.showingPractitionerRegistration = true
                }) {
                    Text("تسجيل الدخول كممارس صحي")
                        .frame( maxWidth: 350, minHeight: 50)                    .background(Color("button"))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .padding(.horizontal)
                }.padding(.top, 510)
                    .fullScreenCover(isPresented: $showingPractitionerRegistration) {
                        HCPOtp()  // Presents the OTP page for health care practitioners when the button is tapped
                    }
            }
            
            
            
            
            
        }// end of zstack
    }
    
    
    
}

// Function to update a value in UserDefaults

public func nameValueUpdate(){
    UserDefaults.standard.set("name", forKey: "myname")
}


// Preview provider for SwiftUI previews in Xcode

#Preview {
    ContentView()
}
