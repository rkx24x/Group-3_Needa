//
//  OTPViewModel.swift
//  NeedaApp
//
//  Created by Ruba Kef on 17/10/1445 AH.
//

import SwiftUI

class OTPViewModel: ObservableObject {
    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 6)
}

