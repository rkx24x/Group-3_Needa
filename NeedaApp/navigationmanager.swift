
// navigationmanager.swift
//NeedaApp

// Created by Ruba Kef on 29/10/1445 AH.


import Foundation
import CoreLocation

// we defined SharedViewModel that conforms to ObservableObject for data binding

class SharedViewModel: ObservableObject {
    @Published var selectedLocation: IdentifiableLocation? // A published property to store the selected location, allowing views to react to changes
    @Published var isActive: Bool = false  // A published property to track if the current navigation state is active, allowing views to react to changes
}




