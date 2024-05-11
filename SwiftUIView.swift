//key id: notifications





//"
//import SwiftUI
//import CloudKit
//import HealthKit
//import WatchConnectivity
//import CommonCrypto
//
//struct PractitionerRegestrationPage: View {
//    
//    @FocusState private var isConfirmPasswordFieldFocused: Bool
//       @FocusState private var isFocused: Bool
//       
//    @State private var showingcompleteYourHealthPage = false
//    @State private var showingContentView = false
//    @Environment(\.presentationMode) var presentationMode
//    @State private var name = ""
//    @State private var idNUM = ""
//    @State private var age = ""
//    @State private var gender: Gender = .notSet
//    @State private var height = ""
//    @State private var weight = ""
//    @State private var phoneNumber = ""
//    @State private var email = ""
//    @State private var saveWord = ""
//    @State private var currentLocation = ""
//    
//    @State private var password = ""
//    @State private var confirmPassword = ""
//    @State private var isLoading = false
//    @State private var errorMessage = ""
//    @State private var nameError = ""
//    @State private var ageError = ""
//    @State private var emailError = ""
//    @State private var passwordError = ""
//    @State private var confirmPasswordError = ""
//    @State private var heightError = ""
//    @State private var weightError = ""
//    @State private var shouldNavigate = false
//    @State private var genderError = ""
//    @State private var idNUMError = ""
//
//    @State private var bubbleText =  "يجب أن تحوي حرف كبير، حرف صغير، رقم، رمز، ٨ خانات على الأقل"
//    @State private var isBubbleVisible = false
//
//   
//
//    // Define consistent padding for all elements
//    private let elementPadding: CGFloat = 20
//    
//    @ObservedObject var locationManager = LocationManager.shared
//    
//    
//    var body: some View {
//        NavigationStack{
//            
//            ZStack {
//                
//                
//                Color("backgroundColor")
//                    .ignoresSafeArea(.all)
//                
//                
//                VStack {
//                    HStack {
//                        Button(action: {
//                            // Dismiss the current view to navigate back
//                            self.showingContentView = true
//                        }) {
//                            HStack {
//                                Image(systemName: "chevron.backward") // The back arrow icon
//                                //Text("رجوع") // The text "Back"
//                            }
//                            .padding()
//                            .foregroundColor(Color("button")) // Change the color as needed
//                        }
//                        .fullScreenCover(isPresented: $showingContentView) {
//                            ContentView()
//                        }
//                        Spacer() // Pushes the button to the left
//                    }
//                    // Make sure the rest of your content is pushed down
//                    Spacer()
//                }
//                .padding(.leading)
//                .zIndex(1)
//                // end of VStack
//                
//                ScrollView {
//                    VStack(spacing: 10) //20
//                    {
//
//                        
//                        Text("إنشاء حساب ممارس صحي")
//                            .font(.title)
//                            .bold()
//                            .padding(.trailing, -20.0) //-60 ->
//                            //.offset(x:70, y:-30)
//                            .foregroundColor(Color("button"))
//                            .multilineTextAlignment(.leading)
//                   
//                        Group {
//                            HStack {
//                                Text("الاسم الثلاثي")
//                                    .foregroundColor(.black)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                Text("*")
//                                    .foregroundColor(.red)
//                                    .padding(.leading, -255)
//                            }  .edgesIgnoringSafeArea(.all)
//                            
//                            
//                            
//                            TextField("", text: $name, onEditingChanged: { editing in
//                                                           if !editing {
//                                                               nameError = validateName(name) ? "" : "أدخل الاسم الثلاثي باللغة العربية "
//                                                           }
//                                                       })
//                            
//                            .foregroundColor(.black)
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(10)
//                              
//                            
//                            if !nameError.isEmpty {
//                                Text(nameError)
//                                    .foregroundColor(.red)
//                            }
//                        }
//                        .environment(\.layoutDirection, .rightToLeft) //end of group 1
//                        
//                        
//                        Group {
//                                                  HStack {
//                                                      Text("الهوية الوطنية")
//                                                          .foregroundColor(.black)
//                                                          .frame(maxWidth: .infinity, alignment: .leading)
//                                                      Text("*")
//                                                          .foregroundColor(.red)
//                                                          .padding(.leading, -248)
//                                                  }
//                                                  
//                                                  TextField("", text: $idNUM, onEditingChanged: { editing in
//                                                      if !editing {
//                                                          idNUMError = validateId(idNUM) ? "" : "أدخل هوية وطنية صحيحة"
//                                                      }
//                                                  })
//                                                  .foregroundColor(.black)
//                                                  .padding()
//                                                  .background(Color.white)
//                                                  .cornerRadius(10)
//                                                  .environment(\.layoutDirection, .rightToLeft)
//                                                  
//                                                  if !idNUMError.isEmpty {
//                                                      Text(idNUMError)
//                                                          .foregroundColor(.red)
//                                                  }
//                                                  
//                                              }.environment(\.layoutDirection, .rightToLeft)
//                        
//                        
//                        Group {
//                            HStack {
//                                Text("الجنس")
//                                    .foregroundColor(.black)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                Text("*")
//                                    .foregroundColor(.red)
//                                    .padding(.leading, -295)
//                            }
//                            
//                            Menu {
//                                Picker("", selection: $gender) {
//                                    ForEach(Gender.allCases) { gender in
//                                        Text(gender.rawValue).tag(gender)
//                                    }
//                                }
//                                .onChange(of: gender) { newValue in
//                                    handleGenderChange(newValue.rawValue)
//                                }
//                            } label: {
//                                HStack {
//                                    Text(gender.rawValue)
//                                        .foregroundColor(.black)
//                                    Spacer()
//                                    Image(systemName: "chevron.down")
//                                        .foregroundColor(.gray)
//                                }
//                                .padding()
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                                .background(Color.white)
//                                .cornerRadius(10)
//                                
//                            }
//                            if !genderError.isEmpty {
//                                Text(genderError)
//                                    .foregroundColor(.red)
//                            }}
//                            .accentColor(.white)
//                            .environment(\.layoutDirection, .rightToLeft)
//                        
//                        Group {
//                                                  HStack {
//                                                      Text("العمر")
//                                                          .foregroundColor(.black)
//                                                          .frame(maxWidth: .infinity, alignment: .leading)
//                                                      Text("*")
//                                                          .foregroundColor(.red)
//                                                          .padding(.leading, -305)
//                                                  }
//                                                  
//                                                  TextField("", text: $age, onEditingChanged: { editing in
//                                                      if !editing {
//                                                          ageError = validateAge(age) ? "" : "أدخل عمرًا بين ١٨ و١٠٠ رجاءً"
//                                                      }
//                                                  })
//                                                  .foregroundColor(.black)
//                                                  .padding()
//                                                  .background(Color.white)
//                                                  .cornerRadius(10)
//                                                  .environment(\.layoutDirection, .rightToLeft)
//                                                  
//                                                  if !ageError.isEmpty {
//                                                      Text(ageError)
//                                                          .foregroundColor(.red)
//                                                  }
//                                                  
//                                              }.environment(\.layoutDirection, .rightToLeft) //end of group3
//                        
//                        
//                        Group {
//                                                  HStack {
//                                                      Text("الطول")
//                                                          .foregroundColor(.black)
//                                                          .frame(maxWidth: .infinity, alignment: .leading)
//                                                      Text("*")
//                                                          .foregroundColor(.red)
//                                                          .padding(.leading, -300)
//                                                  }
//                                                  
//                                                  TextField("", text: $height, onEditingChanged: { editing in
//                                                      if !editing {
//                                                          if !validateHeight(height) {
//                                                              heightError = " أدخل طولًا متاحًا"
//                                                          } else {
//                                                              heightError = ""
//                                                          }
//                                                      }
//                                                  })
//                                                  .foregroundColor(.black)
//                                                  .padding()
//                                                  .background(Color.white)
//                                                  .cornerRadius(10)
//                                                  
//                                                  if !heightError.isEmpty {
//                                                      Text(heightError)
//                                                          .foregroundColor(.red)
//                                                  }
//                                                  
//                                              }.environment(\.layoutDirection, .rightToLeft) //end of group 4
//
//                                              
//                                              Group {
//                                                  HStack {
//                                                      Text("الوزن")
//                                                          .foregroundColor(.black)
//                                                          .frame(maxWidth: .infinity, alignment: .leading)
//                                                      Text("*")
//                                                          .foregroundColor(.red)
//                                                          .padding(.leading, -306)
//                                                  }
//                                                  
//                                                  TextField("", text: $weight, onEditingChanged: { editing in
//                                                      if !editing {
//                                                          if !validateWeight(weight) {
//                                                              weightError = "أدخل وزنًا متاحًا"
//                                                          } else {
//                                                              weightError = ""
//                                                          }
//                                                      }
//                                                  })
//                                                  .foregroundColor(.black)
//                                                  .padding()
//                                                  .background(Color.white)
//                                                  .cornerRadius(10)
//                                                  
//                                                  if !weightError.isEmpty {
//                                                      Text(weightError)
//                                                          .foregroundColor(.red)
//                                                  }
//                                                  
//                                              }.environment(\.layoutDirection, .rightToLeft) //end of group 5
//                                              
//                                              
//                                              
//                                              Group {
//                                                  HStack {
//                                                      Text("البريد الإلكتروني الوزاري")
//                                                          .foregroundColor(.black)
//                                                          .frame(maxWidth: .infinity, alignment: .leading)
//                                                      Text("*")
//                                                          .foregroundColor(.red)
//                                                          .padding(.leading, -180)
//                                                  }
//                                                  
//                                                  TextField("", text: $email, onEditingChanged: { isEditing in
//                                                      if !isEditing {
//                                                          emailError = validateEmail(email) ? "" : "أدخل بريد إلكتروني صحيح"
//                                                      }
//                                                  })
//                                                  .foregroundColor(.black)
//                                                  .padding()
//                                                  .background(Color.white)
//                                                  .cornerRadius(10)
//                                                  .environment(\.layoutDirection, .rightToLeft)
//                                                  
//                                                  if !emailError.isEmpty {
//                                                      Text(emailError)
//                                                          .foregroundColor(.red)
//                                                  }
//                                                  
//                                                  
//                                              }
//                                              .environment(\.layoutDirection, .rightToLeft)
////                        Group {
////                            HStack {
////                                Text("التحقق من البريد الإلكتروني")
////                                    .foregroundColor(.black)
////                                    .frame(maxWidth: .infinity, alignment: .leading)
////                                Text("*")
////                                    .foregroundColor(.red)
////                                    .padding(.leading, -160)
////                            }
////
////                            TextField("", text: $email, onEditingChanged: { isEditing in
////                                if !isEditing {
////                                    emailError = validateEmail(email) ? "" : "أدخل بريد إلكتروني صحيح"
////                                }
////                            })
////                            .foregroundColor(.black)
////                            .padding()
////                            .background(Color.white)
////                            .cornerRadius(10)
////                            .environment(\.layoutDirection, .rightToLeft)
////
////                            if !emailError.isEmpty {
////                                Text(emailError)
////                                    .foregroundColor(.red)
////                            }
////                        }
////                        .environment(\.layoutDirection, .rightToLeft) //email validation
//                                             
//                        Group {
//                            HStack{
//                                Text("كلمة الآمان")
//                                    .foregroundColor(.black)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                    .environment(\.layoutDirection, .rightToLeft)
//                                Text("*")
//                                    .foregroundColor(.red)
//                                    .padding(.leading, -245)
//                                
//                                InfoButtonView(isBubbleVisible: $isBubbleVisible, bubbleText: $bubbleText)
//                                                                      .padding(.leading, -10)
//                                                                      .edgesIgnoringSafeArea(.all)
//                                                                      .onTapGesture {
//                                  
//                                                                          if isBubbleVisible {
//                                                                              isBubbleVisible = false
//                                                                          }
//                                                                      }
//                            }
//                            
//                            SecureField("", text: $saveWord)
//                                .foregroundColor(.black)
//                                .padding()
//                                .background(Color.white)
//                                .cornerRadius(10)
//                                   .focused($isFocused)
//                                   .onChange(of: isFocused) { focused in
//                                       if !focused {
//                                           passwordError = isPasswordStrong(saveWord) ? "" : "كلمة السر لا توافق معايير كلمة السر القوية"
//                                       }
//                                   }
//                            
//                            if !passwordError.isEmpty {
//                                Text(passwordError)
//                                    .foregroundColor(.red)
//                            }
//                        }.environment(\.layoutDirection, .rightToLeft)
//                        
//                        
//                                              Group {
//                                                  HStack{
//                                                      Text("كلمة المرور")
//                                                          .foregroundColor(.black)
//                                                          .frame(maxWidth: .infinity, alignment: .leading)
//                                                          .environment(\.layoutDirection, .rightToLeft)
//                                                      Text("*")
//                                                          .foregroundColor(.red)
//                                                          .padding(.leading, -245)
//                                                      
//                                                      InfoButtonView(isBubbleVisible: $isBubbleVisible, bubbleText: $bubbleText)
//                                                                                            .padding(.leading, -10)
//                                                                                            .edgesIgnoringSafeArea(.all)
//                                                                                            .onTapGesture {
//                                                        
//                                                                                                if isBubbleVisible {
//                                                                                                    isBubbleVisible = false
//                                                                                                }
//                                                                                            }
//                                                  }
//                                                  
//                                                  SecureField("", text: $password)
//                                                      .foregroundColor(.black)
//                                                      .padding()
//                                                      .background(Color.white)
//                                                      .cornerRadius(10)
//                                                         .focused($isFocused)
//                                                         .onChange(of: isFocused) { focused in
//                                                             if !focused {
//                                                                 passwordError = isPasswordStrong(password) ? "" : "كلمة السر لا توافق معايير كلمة السر القوية"
//                                                             }
//                                                         }
//                                                  
//                                                  if !passwordError.isEmpty {
//                                                      Text(passwordError)
//                                                          .foregroundColor(.red)
//                                                  }
//                                              }.environment(\.layoutDirection, .rightToLeft)  //end of group 6
//                                              
//                                              Group {
//                                                  HStack{
//                                                      Text("تأكيد كلمة المرور")
//                                                          .foregroundColor(.black)
//                                                          .frame(maxWidth: .infinity, alignment: .leading)
//                                                      Text("*")
//                                                          .foregroundColor(.red)
//                                                          .padding(.leading, -225)
//                                                  }
//                                                  
//                                                  SecureField("", text: $confirmPassword)
//                                                      .foregroundColor(.black)
//                                                      .padding()
//                                                      .background(Color.white)
//                                                      .cornerRadius(10)
//                                                         .focused($isConfirmPasswordFieldFocused)
//                                                         .onChange(of: isConfirmPasswordFieldFocused) { focused in
//                                                             if !focused{
//                                                                 confirmPasswordError = (password == confirmPassword) ? "" : "كلمتا السر غير متطابقتان"}
//                                                         }
//                                                  
//                                                  if !confirmPasswordError.isEmpty {
//                                                      Text(confirmPasswordError)
//                                                          .foregroundColor(.red)
//                                                  }
//                                              }.environment(\.layoutDirection, .rightToLeft) //end of group 8
//                        
//                        
//                        // Define the navigation destination
//                            .navigationDestination(isPresented: $shouldNavigate) {
//                                completeYourHealthPage().navigationBarBackButtonHidden(true)
//                            }
//                        
//                        Button(action: {
//                            // First, check if the email exists asynchronously
//                            checkIfEmailExists(email) { emailExists in
//                                DispatchQueue.main.async {
//                                    if emailExists {
//                                     
//                                        self.emailError = "البريد الإلكتروني موجود بالفعل."
//                                    } else {
//                                       
//                                        self.emailError = ""
//                                        validateFields()
//                                        registerUser()
//                                        
//                                    }}} }) {
//                            Text("التالي")
//                                .frame(width:300, height:50)
//                                .foregroundColor(Color.white)
//                                .background(Color.button)
//                                .cornerRadius(8)
//                                .padding()
//                        }
//                        
//                        
//                        
//                        
//                    } // end of VStack in side ScrollView
//                    .padding(elementPadding)
//                } // end of ScrollView
//            }.navigationBarHidden(true) // end of container ZStack
//                .onAppear {
//                    fetchHealthData()
//                }
//
//            
//           
//
//        } // end of NavigationStack
//        
//        
//        
//        
//    } // end of the body
//   
//    
//  
//    
//    
//    func fetchHealthData() {
//            HealthDataManager.shared.requestHealthKitPermissions { [self] success, _ in
//                if success {
//                    // Fetch Gender
//                    HealthDataManager.shared.fetchBiologicalSex { result, _ in
//                        if let biologicalSex = try? result?.biologicalSex {
//                            DispatchQueue.main.async {
//                                self.gender = Gender.from(hkBiologicalSex: biologicalSex)
//                            }
//                        }
//                    }
//                    
//                    // Fetch Age
//                    HealthDataManager.shared.fetchDateOfBirth { result, _ in
//                        if let dobComponents = try? result, let birthDate = Calendar.current.date(from: dobComponents), let ageYears = Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year {
//                            DispatchQueue.main.async {
//                                self.age = "\(ageYears)"
//                            }
//                        }
//                    }
//                    
//                    HealthDataManager.shared.fetchHeight { result, error in
//                        // Assuming fetchHeight correctly returns an array of HKQuantitySample? and an Error?
//                        if let error = error {
//                            print("Error fetching height: \(error.localizedDescription)")
//                            return
//                        }
//                        
//                        guard let sample = result?.first else {
//                            print("No height samples available.")
//                            return
//                        }
//                        
//                        let heightValue = sample.quantity.doubleValue(for: HKUnit.meterUnit(with: .centi))
//                        DispatchQueue.main.async {
//                            self.height = String(format: "%.0f", heightValue) // Convert heightValue to a string without decimal points
//                        }
//                    }
//
//                    // Fetch Weight
//                    HealthDataManager.shared.fetchWeight { result, _ in
//                        if let sample = result?.first {
//                            let weightValue = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
//                            DispatchQueue.main.async {
//                                self.weight = String(format: "%.0f", weightValue) // Format and update the UI
//                            }
//                        }
//                    }
//
//                } else {
//                    // Handle the case where permissions were not granted
//                    print("HealthKit permissions were not granted.")
//                }
//            }
//        }
//    
//   //---------------clould kit functions
//    
//    private func registerUser() {
//
//        guard nameError.isEmpty, ageError.isEmpty, emailError.isEmpty,
//               passwordError.isEmpty, confirmPasswordError.isEmpty,
//              heightError.isEmpty, weightError.isEmpty, idNUMError.isEmpty  else {
//               showErrorMessage("Validation failed. Please check the fields again. 335line")
//               return
//           }
//        
//           guard let ageInt = Int(age) else {
//               showErrorMessage("Validation failed. Age, height, or weight is not in the correct format.")
//               return
//           }
//        
//        guard let IdInt = Int(idNUM) else {
//            showErrorMessage("Validation failed. Id, age, height, or weight is not in the correct format.")
//            return
//        }
//        
//        //Create the CloudKit record for HCP Information
//        let individualInfoRecord = CKRecord(recordType: "Individual")
//        individualInfoRecord["Email"] = email
//        individualInfoRecord["FullName"] = name
//        individualInfoRecord["Age"] =  ageInt
//        individualInfoRecord["NationalID"] =  IdInt
//        individualInfoRecord["Gender"] = gender.rawValue
//        individualInfoRecord["Hight"] = height
//        individualInfoRecord["Wight"] = weight
//        individualInfoRecord["UserType"] = "healthcarePractitioner"
//
//        let passwordHash = hashPassword(password)
//        individualInfoRecord["Password"] = passwordHash
//        
//        for (key, value) in individualInfoRecord.allKeys().map({ ($0, individualInfoRecord[$0]!) }) {
//            print("\(key): \(value)")
//        }
//        
//        let container = CKContainer(identifier: "iCloud.NeedaDB")
//        let privateDatabase = container.privateCloudDatabase
//        privateDatabase.save(individualInfoRecord) {  record, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    self.showErrorMessage("CloudKit Save Error: \(error.localizedDescription)")
//                } else if let record = record {
//                  
//                    UserDefaults.standard.set(record.recordID.recordName, forKey: "userRecordID")
//                   // UserDefaults.standard.set(record.recordID.recordName, forKey: "userRecordIDIndivisual")
//                   
//                    self.sendUserNameToWatch(name: self.name)
//                    self.hcpInfo()
//                    
//
//                    self.shouldNavigate = true
//                }
//            }
//            
//        }
//    } // end of func registerUser()
//    
//    
//    private func hcpInfo(){
//        guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID")
//                  else {
//               print("User record ID not found.")
//               return
//           }
//        
//        guard let userLocation = locationManager.userLocation else {
//             print("User location not found.")
//             return
//         }
//        
//        let container = CKContainer(identifier: "iCloud.NeedaDB")
//        let privateDatabase = container.privateCloudDatabase
//        let userRecordID = CKRecord.ID(recordName: userRecordIDString)
//        
//        let healthcare = CKRecord(recordType: "HCP")
//        healthcare["saveword"] = saveWord
//        healthcare["location"] = userLocation
//
//        let reference = CKRecord.Reference(recordID: userRecordID , action: .deleteSelf)
//        healthcare["UserID"] = reference
//        
//        privateDatabase.save(healthcare) { record , error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    print("CloudKit Save Error: \(error.localizedDescription)")  // Print the error message
//                } else {
//                    UserDefaults.standard.set(healthcare.recordID.recordName, forKey: "userRecordIDhcp")
//                    print(" saveword saved to CloudKit.")
//                   
//                }
//            }
//        }
//    }
// // end of the hcpInfo
//    
//    // Method to send the user's name to the Apple Watch
//      private func sendUserNameToWatch(name: String) {
//          if WCSession.default.isReachable {
//              let message = ["userName": name]
//              WCSession.default.sendMessage(message, replyHandler: nil) { error in
//                  DispatchQueue.main.async {
//                      // Handle any errors here, perhaps by showing an error message to the user
//                      self.showErrorMessage("Could not send user name to the Apple Watch: \(error.localizedDescription)")
//                  }
//              }
//          }
//      }
//    
//    private func hashPassword(_ password: String) -> String {
//        // Convert the password string to data using UTF-8 encoding
//        guard let data = password.data(using: .utf8) else { return "defaultHashValue" }
//        
//        // Initialize an array to hold the hash
//        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
//        
//        // Calculate the SHA-256 hash of the password data
//        data.withUnsafeBytes {
//            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
//        }
//        
//        // Convert the hash array to Data, then encode it in Base64
//        let hashedPassword = Data(hash).base64EncodedString()
//        
//        // Return the hashed password
//        return hashedPassword
//    }
//
//    
//// Function to show an error message to the user
//    private func showErrorMessage(_ message: String) {
//        print("error func showErrorMessage 405line registraion page")
//    }
//    
//    //--------------- end of clould kit functions
//    
//    
//    //--------------- vaildation function
//    
// 
//    
//    func validateFields() {
//           nameError = ""
//           ageError = ""
//           emailError = ""
//           passwordError = ""
//           confirmPasswordError = ""
//           heightError = ""
//           weightError = ""
//           genderError = ""
//        idNUMError = ""
//           
//           isLoading = true
//
//              // Validate name
//              nameError = name.isEmpty || !validateName(name) ? "أدخل الاسم" : ""
//           
//
//              // Validate age
//              ageError = age.isEmpty || !validateAge(age) ? "أدخل عمرًا بين ١٨ و١٠٠ رجاءً" : ""
//        
//        // Validate id
//        idNUMError = idNUM.isEmpty || !validateId(idNUM) ? "أدخل هوية وطنية صحيحة" : ""
//
//              // Validate email
//              emailError = email.isEmpty || !validateEmail(email) ? "أدخل بريد الكتروني صحيح" : ""
//
//              // Validate password
//              passwordError = password.isEmpty ? " أدخل كلمة السر" : ""
//              
//    // Validate passwordStrength
//              passwordError = isPasswordStrong(password) ? "" : " كلمة السر لا توافق معايير كلمة السر القوية"
//
//              // Validate confirmPassword
//              confirmPasswordError = confirmPassword.isEmpty ? "أدخل كلمة السر مرة أخرى" : ""
//              
//              // Validate height
//              heightError = height.isEmpty || !validateHeight(height) ? " أدخل طولًا متاحًا" : ""
//              
//              // Validate weight
//              weightError = weight.isEmpty || !validateWeight(weight) ? "أدخل وزنًا متاحًا" : ""
//              
//           handleGenderChange(gender.rawValue)
//           
//              // Set isLoading to false if there are errors
//        if !nameError.isEmpty || !ageError.isEmpty || !emailError.isEmpty || !passwordError.isEmpty || !confirmPasswordError.isEmpty || !heightError.isEmpty || !weightError.isEmpty || !genderError.isEmpty || !idNUMError.isEmpty {
//                  isLoading = false
//              }
//          
//           
//         //  let user = createUser()
//         //  saveUserToCloudKit(user)
//       }
//       
//     
//    func isPasswordStrong(_ password: String) -> Bool {
//        // Define the checks
//        let lengthCheckPredicate = NSPredicate(format: "SELF MATCHES %@", ".{8,}") // At least 8 characters
//        let lowercaseCheckPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
//        let uppercaseCheckPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
//        let digitCheckPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
//        let specialCharacterCheckPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[^A-Za-z0-9]+.*")
//
//        // Evaluate each check and print out the result
//        let isLengthValid = lengthCheckPredicate.evaluate(with: password)
//        print("Length valid: \(isLengthValid)")
//        
//        let isLowercaseValid = lowercaseCheckPredicate.evaluate(with: password)
//        print("Lowercase valid: \(isLowercaseValid)")
//        
//        let isUppercaseValid = uppercaseCheckPredicate.evaluate(with: password)
//        print("Uppercase valid: \(isUppercaseValid)")
//        
//        let isDigitValid = digitCheckPredicate.evaluate(with: password)
//        print("Digit valid: \(isDigitValid)")
//        
//        let isSpecialCharacterValid = specialCharacterCheckPredicate.evaluate(with: password)
//        print("Special Character valid: \(isSpecialCharacterValid)")
//        
//        // Return the combined result
//        return isLengthValid && isLowercaseValid && isUppercaseValid && isDigitValid && isSpecialCharacterValid
//    }
//
//
//           
//
//    func validateName(_ name: String) -> Bool {
//       
//        let nameRegex = "^[\\u0600-\\u06FF]+(\\s+[\\u0600-\\u06FF]+){2,}\\s*$"
//
//        let nameValidation = NSPredicate(format: "SELF MATCHES %@", nameRegex)
//        return nameValidation.evaluate(with: name)
//    }
//
//
//
//           func validateAge(_ age: String) -> Bool {
//                let ageRegex = NSPredicate(format: "SELF MATCHES %@", #"^(1[8-9]|[2-9][0-9]|100)$"#)
//                return ageRegex.evaluate(with: age)
//            }
//
//               
//
//                func validateEmail(_ email: String) -> Bool {
//                    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//                    let emailValidation = NSPredicate(format: "SELF MATCHES %@", emailRegex)
//                    return emailValidation.evaluate(with: email)
//                }
//           
//    func validateHeight(_ height: String) -> Bool {
//        let heightRegex = #"^([1-2][0-9][0-9]|300)$"#
//        let heightValidation = NSPredicate(format: "SELF MATCHES %@", heightRegex)
//        return heightValidation.evaluate(with: height)
//    }
//
//    // Method to validate weight
//    func validateWeight(_ weight: String) -> Bool {
//        let weightRegex = #"^([0-3]?[2-9][0-9]|400)$"#
//        let weightValidation = NSPredicate(format: "SELF MATCHES %@", weightRegex)
//        return weightValidation.evaluate(with: weight)
//    }
//
//       
//       func handleGenderChange(_ gender: String) {
//              if gender == "غير محدد" {
//                  genderError = "يجب عليك تحديد الجنس"
//              } else {
//                  genderError = ""
//              }
//          }
//       
//    
//    private func checkIfEmailExists(_ email: String, completion: @escaping (Bool) -> Void) {
//        let predicate = NSPredicate(format: "Email == %@", email)
//        let query = CKQuery(recordType: "Individual", predicate: predicate)
//        
//        let container = CKContainer(identifier: "iCloud.NeedaDB")
//        let privateDatabase = container.privateCloudDatabase
//
//        privateDatabase.perform(query, inZoneWith: nil) { records, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    self.errorMessage = "Error checking email: \(error.localizedDescription)"
//                    completion(false)
//                } else if let records = records, !records.isEmpty {
//                    // Email exists if records are returned
//                    self.errorMessage = "البريد الإلكتروني موجود بالفعل."
//                    completion(true)
//                } else {
//                    // Email does not exist if no records are returned
//                    completion(false)
//                }
//            }
//        }
//    }
//    
//    
//    private func validateId(_ idNUM: String) -> Bool{
//        let idRegex = NSPredicate(format: "SELF MATCHES %@", "^\\d{10}$")
//        return idRegex.evaluate(with: idNUM)
//    }
//
//
//} // end of struct patientRegestrationPage
//
//
//
//
//extension Gender {
//    static func genderFromBiologicalSex(_ hkBiologicalSex: HKBiologicalSex?) -> Gender {
//        guard let biologicalSex = hkBiologicalSex else {
//            return .notSet
//        }
//        
//        switch biologicalSex {
//        case .female: return .female
//        case .male: return .male
//        default: return .notSet
//        }
//    }
//}
//
//
//
//#Preview {
//    PractitionerRegestrationPage()
//}
//" and "
//import Foundation
//import UIKit
//import UserNotifications
//import CloudKit
//
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    // This method is called when the app finishes launching.
//    // It sets up the notification permissions and registers for remote notifications.
////    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
////        // Request permission to display alerts and play sounds.
////        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
////            // Check if permission was granted
////            if granted {
////                // Main thread is used because UI updates must be on the main thread and registering for notifications involves UI changes.
////                DispatchQueue.main.async {
////                    application.registerForRemoteNotifications()
////                }
////            } else {
////                print("User denied notifications.")
////            }
////        }
////        return true
////    }
//
//    // This method is called when the device successfully registers for remote notifications.
//    // It handles the device token needed for sending notifications to the device.
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        // Convert the binary device token to a string
//        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
//        let token = tokenParts.joined()
//        print("Device Token: \(token)")
//
//        // Send the device token to CloudKit for future reference and use in push notifications.
//        sendDeviceTokenToCloudKit(token: token)
//    }
//
//    // This method is called if the device fails to register for remote notifications.
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("Failed to register for remote notifications: \(error)")
//    }
//
//    // This function sends the device token to CloudKit to store it in the existing user's record.
//    func sendDeviceTokenToCloudKit(token: String) {
//        // Check if the userRecordID is available
//        guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") else {
//            print("User record ID not found. Unable to save the token.")
//            return
//        }
//        
//        // Create a record ID with the retrieved userRecordIDString
//        let userRecordID = CKRecord.ID(recordName: userRecordIDString)
//        
//        // Access the private database
//        let container = CKContainer(identifier: "iCloud.NeedaDB")
//        let privateDatabase = container.privateCloudDatabase
//        
//        // Fetch the existing record using the record ID
//        privateDatabase.fetch(withRecordID: userRecordID) { record, error in
//            if let error = error {
//                print("Failed to fetch user record in the AppDelegate : \(error.localizedDescription)")
//                return
//            }
//            
//            guard let record = record else {
//                print("Record not found for given userRecordID. in the AppDelegate")
//                return
//            }
//            
//            // Set the token field of the user record
//            record["token"] = token
//            
//            DispatchQueue.main.async{
//                // Save the updated record back to CloudKit
//                privateDatabase.save(record) { savedRecord, error in
//                    if let error = error {
//                        print("Error saving token to CloudKit in the AppDelegate: \(error.localizedDescription)")
//                    } else {
//                        print("Token updated in CloudKit successfully for the existing user. in the AppDelegate")
//                    }
//                }
//            }
//           
//            
//        }
//    }
//
//    
//    
//}
//" and "
//import SwiftUI
//import CoreLocation
//import CloudKit
//
//struct NeedaHomePage: View {
//    
//    
//    @State private var showingPatientMedicalHistory = false
//    @State private var showingPatientHealthInfo = false
//    @State private var showingPatientStatistics = false
//    @State private var showAlert = false
//    
//    //  @ObservedObject var viewModel: HealthInfoViewModel
//    @State private var goToAppStore = false
//    @State private var showingAlert = false
//    @Environment(\.openURL) var openURL
//    
//    @ObservedObject var callerlocationManager = LocationManager.shared
//    var body: some View {
//
//        ZStack {
//            Color("backgroundColor")
//                .ignoresSafeArea(.all)
//            
//            VStack { // Start of VStack
//               
//                        HStack { // Start of top HStack for icons
//                            Image("needasmall") // Icon for users or contacts
//                                .resizable() // Make image resizable
//                                .aspectRatio(contentMode: .fit) // Maintain aspect ratio
//                                .frame(width: 120, height: 120) // Set frame for image
//                                .padding()
//                            // End of needasmall Image
//
//                            Spacer() // Pushes icons to edges
//                            
//                        } // End of top HStack
//                        .padding(.top, -30) //-30
//
//                        Spacer() // Spacer to push content to top and bottom
//
//                Button(action: {
//                    
//                    showAlert = true
//                    
//                    
//                }) {
//                    Text("نداء") // 'Call' button text
//                        .font(.system(size: 80)) // Font for the button , 60
//                        .foregroundColor(.white)
//                        .frame(width: 230, height: 230) // Set frame for button , width: 190, height: 190
//                        .background(Color("button")) // Set button color
//                        .clipShape(Circle())
//                        .overlay(
//                            Circle()
//                                .stroke(Color.white, lineWidth: 4)
//                        )
//                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
//                        .padding(.bottom, 50)
//                } // End of Call button
//                .alert(isPresented: $showAlert) {
//                    Alert(
//                        title: Text("تأكيد النداء"),
//                        message: Text("هل أنت متأكد أنك تريد إرسال نداء الحاجة؟"),
//                        primaryButton: .destructive(Text("نعم")) {
//                            sendNeedaCall { (record) in
//                                // Handle the returned CKRecord or perform other actions after the function completes
//                                if let record = record {
//                                    // Do something with the returned record
//                                    print("Received record: \(record)")
//                                } else {
//                                    print("No record received")
//                                }
//                            }
//                           
//                        },
//                        secondaryButton: .cancel(Text("إلغاء"))
//                    )
//                }
//                
//                        Spacer() // Spacer to push content to top and bottom
//
//                        HStack { // Start of bottom HStack for icons and text
//                            
//                            VStack { // Start of VStack for health information icon and text
//                                Button(action: {
//                                    // Action to navigate to health information page
//                                    self.showingPatientHealthInfo = true
//                                }) {
//                                    Image(systemName: "heart.text.square") // Icon for health information
//                                        .foregroundColor(.white)
//                                        .imageScale(.large)
//                                }
//                                Text("معلوماتي الصحية") // Text label for icon
//                                    .foregroundColor(.white)
//                                    .font(.caption)
//                            } // End of VStack for health information icon and text
//                            .fullScreenCover(isPresented: $showingPatientHealthInfo) {
//                                newViewHealthInfoPage()
//                            }
//                   
//                            Spacer()
//
//                            VStack {
//                                Button(action: {
//                                    self.showingPatientMedicalHistory = true
//                                }) {
//                                    Image(systemName: "book.closed")
//                                        .foregroundColor(.white)
//                                        .imageScale(.large)
//                                }
//                                Text("التاريخ الطبي")
//                                    .foregroundColor(.white)
//                                    .font(.caption)
//                            }
//                            .fullScreenCover(isPresented: $showingPatientMedicalHistory) {
//                                NewmedicalHistory()
//                            }
//                            
//                            
//                            Spacer()
//
//                            
//                        } // End of bottom HStack
//                
//                        .frame(maxWidth: 330)
//                        .padding()
//                        .background(Color("button"))
//                        .cornerRadius(20)
//            }// End of VStack
//            .onAppear{
//                requestNotificationPermission()
//            }
//            
//        }
//       
//        
//        
//    }
//     
//    
//    func sendNeedaCall(completion: @escaping (CKRecord?) -> Void) {
//        var closeLocations : [String: CLLocation] = [:]
//      
//        let container = CKContainer(identifier: "iCloud.NeedaDB")
//        let privateDatabase = container.privateCloudDatabase
//        
//        // Retrieve the stored user record ID
//        if let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") {
//            let userRecordID = CKRecord.ID(recordName: userRecordIDString)
//            
//
//            // Fetch and update the existing record
//            privateDatabase.fetch(withRecordID: userRecordID) { record, error in
//                if let error = error {
//                    print("Error fetching record: \(error.localizedDescription)")
//                    completion(nil)
//                    return
//                    
//                }
//               
//                print(userRecordIDString)
//                guard let userLocation = callerlocationManager.userLocation else {
//                    print("User location not found.")
//                    return
//                }
//                
//                let container = CKContainer(identifier: "iCloud.NeedaDB")
//                let privateDatabase = container.privateCloudDatabase
//                let predicate = NSPredicate(value: true)
//                let query = CKQuery(recordType: "HCP", predicate: predicate)
//                
//                privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
//                    DispatchQueue.main.async {
//                        if let error = error {
//                            print("CloudKit Query Error: \(error.localizedDescription)")
//                            return
//                        }
//                        
//                        guard let records = records else {
//                            print("No records found")
//                            return
//                        }
//                        
//                        var locations: [String: CLLocation] = [:]
//                        
//                        for record in records {
//                            
//                            if let location = record["location"] as? CLLocation,
//                               let reference = record["UserID"] as? CKRecord.Reference {
//                                let recordName = reference.recordID.recordName
//                                if recordName != userRecordIDString {
//                                    locations[recordName] = location
//
//                                }
//                            } else {
//                                print("Error: Failed to parse record. Record details: \(record)")
//                                continue
//                            }
//                        }
//                        
//                        if locations.isEmpty {
//                            print("No valid locations found in records.")
//                            return
//                        }
//                        
//                        print("List of HCP Locations:")
//                        for (name, location) in locations {
//                            print("Name: \(name), Location: \(location)")
//                        }
//                        
//                        for (name, loc) in locations {
//                            let distanceInMeters = userLocation.distance(from: loc)
//                            
//                            if distanceInMeters < 250 {
//                                closeLocations[name] = loc
//                            }
//                        }
//                        
//                        if closeLocations.isEmpty {
//                            print("No nearby locations found.")
//                            return
//                        }
//                        
//                        // Convert closeLocations dictionary to a readable string
//                        var result = "Nearby locations:\n"
//                        for (name, loc) in closeLocations {
//                            result += "Name: \(name), Latitude: \(loc.coordinate.latitude), Longitude: \(loc.coordinate.longitude)\n"
//                        }
//                        print(result)
//                        
//                    }
//                }
//            }
//            
//        }
//    }
//    
//    func requestNotificationPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//            if success {
//                // Handle success - for example, you might want to call a function to register for remote notifications.
//                DispatchQueue.main.async {
//                    UIApplication.shared.registerForRemoteNotifications()
//                }
//            } else if let error = error {
//                // Handle errors here
//                print("Notification permission error: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    
//} //end of the struct NeedaHomePage
//
//
//
//
//#Preview {
//   
//    NeedaHomePage()
//}
//" next, in sendNeedaCall() I want to make an array to save the token corresponding to record names in closeLocations
