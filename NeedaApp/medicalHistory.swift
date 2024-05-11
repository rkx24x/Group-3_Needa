//
//  medicalHistory.swift
//  NeedaApp
//
//  Created by Alanoud on 07/09/1445 AH.
//

import SwiftUI
import HealthKit
import CloudKit


/// View displaying the medical history information.
struct NewmedicalHistory: View {
    
    @State private var showUpdateView = false
    @State private var showUpdateView2 = false
    @State private var showUpdateView3 = false
    @State private var showUpdateView4 = false
    @State private var showUpdateView5 = false
    @State private var showUpdateView6 = false
    
    @State private var showAddMedicationView = false
    @State private var showSurguryView = false
    @State private var showAddChronincView = false
    
    @State private var showDeleteMedicationView = false
    @State private var showDeleteSurguryView = false
    @State private var showDeleteChronicView = false
    
    
    @State private var showingHomePage = false // State for showing home page
    @State private var heartRate: String = "لا توجد بيانات"
    @State private var personname: String = "لا توجد بيانات"
    @State private var age: Int = 0
    @State private var idNUM: Int = 0
    @State private var gender: String = "لا توجد بيانات"
    
    
    @State private var bloodOxygen: String = "لا توجد بيانات"
    @State private var bloodPressure: String = "لا توجد بيانات"
    @State private var bodyTemperature: String = "لا توجد بيانات"
    @State private var bloodType: String = "لا توجد بيانات"
    @State private var weight: String = "لا توجد بيانات"
    @State private var height: String = "لا توجد بيانات"
    @State private var alergies: String = "لا توجد بيانات"
    @State private var medications: [String] = []
    @State private var chronincs: [String] = []
    @State private var medicalNotes: String = "لا توجد بيانات"
    @State private var surgeries: [String] = []
    @State private var personal: [String] = []
    
    @State var surgeryNames: [String] = []
    @State var surgeryYears: [String] = []
    @State var MedicationNames: [String] = []
    @State var Medicationdoses: [String] = []
    @State var Medicationunits: [String] = []
    @State var chronincNames: [String] = []
    
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea(.all)
            
            NavigationView {
                ScrollView {
                    VStack {
                        // MARK: Top Bar
                        HStack {
                            Button(action: {
                                self.showingHomePage = true
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .offset(x: 20 , y: -19)
                                        .foregroundColor(.red)
                                    
                                }
                            }
                            
                            Spacer()
                            
                            
                            Text("التاريخ الطبي")
                                .font(.title)
                                .bold()
                                .foregroundColor(.red)
                                .offset(x: -20, y: 10)
                                .padding(.bottom , 50)
                            // Spacer()
                        }
                        //  .padding(.vertical)
                        .fullScreenCover(isPresented: $showingHomePage) {
                            NeedaHomePage()
                        }
                        
                        // MARK: Health Information Cards
                        ZStack {
                            HealthCardPersonaInfo(title: "المعلومات الشخصية:", personal: self.personal, graphName: "note.text", color: .green)
                            
                            HStack {
                                Button(action: {
                                    // This will set showUpdateView to true, presenting the modal
                                    
                                    
                                    self.showUpdateView = true
                                }) {
                                    Image(systemName: "pencil.circle.fill") // Using a pencil icon
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                        .padding()
                                }
                                .sheet(isPresented: $showUpdateView) {
                                    UpdateView(personal: $personal, onApply: {
                                        self.updatePersonalInformation()
                                    })
                                }}  .padding(EdgeInsets(top: 140, leading: 300, bottom: 0, trailing: 0))
                        }.environment(\.layoutDirection, .rightToLeft)
                        
                        
                        VStack {
                            // Start of HStack for health cards
                            HealthCardtwo(title: "نبضات القلب", value:"\(heartRate) ", graphName: "heart.fill" , color: .red,isSystemImage: true)
                            // End of Heart Rate HealthCard
                            
                            
                        }.environment(\.layoutDirection, .rightToLeft)
                        
                        VStack{
                            HealthCardtwo(title: "اكسجين الدم", value: "\(bloodOxygen)", graphName: "o.circle.fill", color: .blue,isSystemImage: true)
                            // End of Oxygen Level HealthCard
                        }.environment(\.layoutDirection, .rightToLeft)
                        
                        
                        
                        VStack {
                            
                            HealthCardtwo(title: "فصيلة الدم", value: "\(bloodType)", graphName: "drop.fill", color: .red,isSystemImage: true)
                            // End of Blood Type HealthCard
                            
                            // End of Medication HealthCard
                            
                        }.environment(\.layoutDirection, .rightToLeft)
                        
                        VStack{
                            HealthCardtwo(title: "الطول", value: "\(height)", graphName: "ruler", color: .red,isSystemImage: true)
                            // End of Blood Type HealthCard
                        }.environment(\.layoutDirection, .rightToLeft)
                        
                        VStack {
                            HealthCardtwo(title: "الوزن", value: "\(weight)", graphName: "scalemass", color: .yellow,isSystemImage: true)
                            // End of Medication HealthCard
                        }.environment(\.layoutDirection, .rightToLeft)
                        
                        ZStack {
                            HealthCardMedication(title: "الأدوية", medications: self.medications, graphName: "pills.fill", color: .blue)
                            
                            HStack{
                                Button(action: {
                                    // This will set showUpdateView to true, presenting the modal
                                    prepareMedicatinData(medications: medications)
                                    
                                    self.showUpdateView5 = true
                                    
                                }) {
                                    Image(systemName: "pencil.circle.fill") // Using a pencil icon
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                    // .padding()
                                }
                                .sheet(isPresented: $showUpdateView5) {
                                    UpdateMedicationView(medications: $medications, MedicationNames: $MedicationNames
                                                         , Medicationdoses: $Medicationdoses, Medicationunits: $Medicationunits
                                                         ,onApply: {
                                        self.updateMedications(MedicationNames: MedicationNames, Medicationdoses: Medicationdoses, Medicationunits: Medicationunits)  { success in
                                            
                                            print("Update completion with success: \(success)")
                                        }
                                    })
                                }
                                
                                
                                
                                Button(action: {
                                    // This will show a UI to add new medication
                                    self.showAddMedicationView = true
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.green)
                                        .padding()
                                }
                                .sheet(isPresented: $showAddMedicationView) {
                                    AddMedicationView(onAdd: { name, dose, unit in
                                        self.addNewMedication(name: name, dose: dose, unit: unit)
                                    })
                                }
                                
                                
                                Button(action: {
                                    showDeleteMedicationView = true
                                }) {
                                    Image(systemName: "trash.circle.fill")
                                        .resizable()
                                        .foregroundColor(.red)
                                        .frame(width: 30, height: 30)
                                }
                                .sheet(isPresented: $showDeleteMedicationView) {
                                    
                                    DeleteMedicationView(medications: $medications)
                                }
                                
                            }.padding(EdgeInsets(top: 95, leading: 190, bottom: 0, trailing: 0))
                            
                        }.environment(\.layoutDirection, .rightToLeft)
                        ZStack{
                            HealthCardtwo(title: "الحساسية", value: "\(alergies)", graphName: "food-allergy_2248584", color: .red,isSystemImage: false)
                            
                            HStack{   Button(action: {
                                // This will set showUpdateView to true, presenting the modal
                                
                                
                                self.showUpdateView2 = true
                            }) {
                                Image(systemName: "pencil.circle.fill") // Using a pencil icon
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            .sheet(isPresented: $showUpdateView2) {
                                UpdateViewAllergy(allergies: $alergies, onApply: {
                                    self.updateAllergies()
                                })
                            }}.padding(EdgeInsets(top: 95, leading: 300, bottom: 0, trailing: 0))
                            
                        }.environment(\.layoutDirection, .rightToLeft)
                        
                        
                        
                        ZStack {
                            HealthCardSurgeries(title: "العمليات السابقة", surgeries: self.surgeries,  color: .brown)
                            
                            HStack{
                                Button(action: {
                                    // This will set showUpdateView to true, presenting the modal
                                    prepareSurgeryData(surgeries: surgeries)
                                    
                                    self.showUpdateView4 = true
                                    
                                }) {
                                    Image(systemName: "pencil.circle.fill") // Using a pencil icon
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                    // .padding()
                                }
                                .sheet(isPresented: $showUpdateView4) {
                                    UpdateSurgeriesView(surgeryNames: $surgeryNames, surgeryYears: $surgeryYears, surgeries: $surgeries
                                                        ,onApply: {
                                        self.updateSurgeries(surgeryNames: surgeryNames, surgeryYears: surgeryYears) { success in
                                            // Handle completion. For example, you might want to show an alert or log a message.
                                            print("Update completion with success: \(success)")
                                        }
                                    })
                                }
                                
                                
                                Button(action: {
                                    // This will show a UI to add new surgery
                                    self.showSurguryView = true
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.green)
                                        .padding()
                                }
                                .sheet(isPresented: $showSurguryView) {
                                    AddSurgyryView(onSurgeryAdd: { name, year in
                                        self.addNewSurgury(name: name, year: year)
                                    })
                                }
                                Button(action: {
                                    showDeleteSurguryView = true
                                }) {
                                    Image(systemName: "trash.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                }
                                .sheet(isPresented: $showDeleteSurguryView) {
                                    
                                    DeleteSurgeryView(surgeries: $surgeries)
                                }}.padding(EdgeInsets(top: 150, leading: 200, bottom: 0, trailing: 0))
                            
                            
                        }.environment(\.layoutDirection, .rightToLeft)
                        
                        ZStack {
                            HealthCardChronic(title: "الامراض المزمنة",  chronincs: self.chronincs, color: .yellow)
                            
                            HStack{
                                Button(action: {
                                    // This will set showUpdateView to true, presenting the modal
                                    prepareChronicData(chronincs: chronincs )
                                    
                                    self.showUpdateView6 = true
                                }) {
                                    Image(systemName: "pencil.circle.fill") // Using a pencil icon
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                    
                                }
                                .sheet(isPresented: $showUpdateView6) {
                                    UpdateChronicView(chronincs: $chronincs, chronincNames: $chronincNames, onApply: {
                                        self.updateChronic(chronincNames: chronincNames){ success in
                                            
                                            print("Update completion with success: \(success)")
                                        }
                                    })
                                }
                                
                                Button(action: {
                                    // This will show a UI to add new chroninc
                                    self.showAddChronincView = true
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.green)
                                        .padding()
                                }
                                .sheet(isPresented: $showAddChronincView) {
                                    AddChronincView(onChronincAdd: { name in
                                        self.addNewChroninc(name: name)
                                    })
                                }
                                
                                Button(action: {
                                    showDeleteChronicView = true
                                }) {
                                    Image(systemName: "trash.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.red)
                                }
                                .sheet(isPresented: $showDeleteChronicView) {
                                    
                                    DeleteChronicView(chronincs: $chronincs)
                                }
                            }
                            .padding(EdgeInsets(top: 150, leading: 200, bottom: 0, trailing: 0))
                            
                        }.environment(\.layoutDirection, .rightToLeft)
                        
                        
                        VStack {
                            HealthCardtwo(title: "  الملاحظات الطبية", value: "\(medicalNotes)", graphName: "pencil.and.list.clipboard", color: .blue,isSystemImage: true)
                            
                            HStack{
                                Button(action: {
                                // This will set showUpdateView to true, presenting the modal
                                
                                
                                self.showUpdateView3 = true
                            }) {
                                Image(systemName: "pencil.circle.fill") // Using a pencil icon
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            .sheet(isPresented: $showUpdateView3) {
                                UpdateViewnotes(medicalNotes: $medicalNotes, onApply: {
                                    self.updateMedNotes()
                                })
                            }}
                            .padding(EdgeInsets(top: -70, leading: 310, bottom: 0, trailing: 0))
                            
                        }.environment(\.layoutDirection, .rightToLeft)
                       
                        
                        
                        
                    }
                }
                .navigationBarHidden(true)
            }
        }.onAppear {
            fetchHealthData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Wait for 1 second before calling update 1.0
                retriveHealthData()
            }
            
        }
        
        .fullScreenCover(isPresented: $showingHomePage) {
            NeedaHomePage()
        }
    }
    
    
    //------------ health kit functions
    
    private func fetchHealthData() {
        // Ensure to request permissions before fetching
        HealthDataManager.shared.requestHealthKitPermissions { success, _ in
            guard success else { return }
            
            HealthDataManager.shared.fetchHeartRate { sample, _ in
                if let sample = sample {
                    let value = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
                    self.heartRate = "\(Int(value)) bpm"
                }
            }
            
            HealthDataManager.shared.fetchBloodOxygen { sample, _ in
                if let sample = sample {
                    let value = sample.quantity.doubleValue(for: HKUnit.percent())
                    self.bloodOxygen = String(format: "%.1f%%", value * 100)
                }
            }
            
            
            
            HealthDataManager.shared.fetchBloodType { bloodTypeObject, _ in
                if let bloodTypeObject = bloodTypeObject {
                    let bloodTypeString = convertBloodTypeToString(bloodTypeObject)
                    self.bloodType = bloodTypeString
                }
            }
            
            
            HealthDataManager.shared.fetchWeight { samples, _ in
                if let sample = samples?.first {
                    let value = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                    self.weight = "\(Int(value)) kg"
                }
            }
            
            HealthDataManager.shared.fetchHeight { samples, _ in
                if let sample = samples?.first {
                    let value = sample.quantity.doubleValue(for: HKUnit.meter())
                    self.height = String(format: "%.2f m", value)
                }
            }
        }
    }
    
    //------------ clould kit functions
    
    private func retriveHealthData() {
        // Assuming userRecordID and healthInfoRecord are already saved in UserDefaults after registration and health info submission
        
        print("\(UserDefaults.standard.string(forKey: "userRecordID"))")
        print("\(UserDefaults.standard.string(forKey: "healthInfoRecord"))")
        print("\(UserDefaults.standard.string(forKey: "chroincRecord"))")

        guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID"),
              let healthInfoRecordIDString = UserDefaults.standard.string(forKey: "healthInfoRecord") ,
              let chrioncRecordIDString = UserDefaults.standard.string(forKey: "chroincRecord")else {
            print("User record ID not found line 213")
            return
        }
        
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        
        let userRecordID = CKRecord.ID(recordName: userRecordIDString)
        let healthInfoRecordID = CKRecord.ID(recordName: healthInfoRecordIDString)
        let chrioncRecordID = CKRecord.ID(recordName: chrioncRecordIDString)
        
        // Fetch Individual Record for Height and Weight
        privateDatabase.fetch(withRecordID: userRecordID) { record, error in
            DispatchQueue.main.async {
                if let record = record, error == nil {
                    self.personname = record["FullName"] as? String ?? "No data"
                    self.age = record["Age"] as? Int ?? 0
                    self.idNUM = record["NationalID"] as? Int ?? 0
                    
                    self.gender = record["Gender"] as? String ?? "No data"
                    self.personal.append(personname)
                    self.personal.append("\(age)")
                    self.personal.append(gender)
                    self.personal.append("\(idNUM)")
                    
                    
                } else {
                    print("Error fetching individual record Hight and Wight: \(error?.localizedDescription ?? "No error description")")
                }
            }
        }
        
        
        // Fetch Individual Record for name and age
        privateDatabase.fetch(withRecordID: userRecordID) { record, error in
            DispatchQueue.main.async {
                if let record = record, error == nil {
                    self.height = record["Hight"] as? String ?? "No data"
                    self.weight = record["Wight"] as? String ?? "No data"
                } else {
                    print("Error fetching individual record Hight and Wight: \(error?.localizedDescription ?? "No error description")")
                }
            }
        }
        
        // Fetch Health Information Record for Blood Type
        privateDatabase.fetch(withRecordID: healthInfoRecordID) { record, error in
            DispatchQueue.main.async {
                if let record = record, error == nil {
                    self.bloodType = record["BloodType"] as? String ?? "No data"
                    self.alergies = record["Allergies"] as? String ?? "No data"
                } else {
                    print("Error fetching health information record BloodType and Allergies: \(error?.localizedDescription ?? "No error description")")
                }
            }
        }
        
        // Fetch Health Information Record for Blood Type
        privateDatabase.fetch(withRecordID: healthInfoRecordID) { record, error in
            DispatchQueue.main.async {
                if let record = record, error == nil {
                    self.medicalNotes = record["MedicalNotes"] as? String ?? "No data"
                } else {
                    print("Error fetching health information record DiseseName: \(error?.localizedDescription ?? "No error description")")
                }
            }
        }
        
        
        // Fetch chroinc Record
        /*   privateDatabase.fetch(withRecordID: chrioncRecordID) { record, error in
         DispatchQueue.main.async {
         if let record = record, error == nil {
         self.chronincName = record["DiseseName"] as? String ?? "No data"
         } else {
         print("Error fetching health information record DiseseName: \(error?.localizedDescription ?? "No error description")")
         }
         }
         }
         */
        
        let predicate3 = NSPredicate(format: "UserID == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
        let query3 = CKQuery(recordType: "ChroincDiseses", predicate: predicate3)
        
        privateDatabase.perform(query3, inZoneWith: nil) { records, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle the error appropriately
                    print("Error fetching chronic desies records: \(error.localizedDescription)")
                    return
                }
                //
                guard let records = records else {
                    print("No chronic desies records found for user.")
                    return
                }
                //
                for record in records {
                    if let cname = record["DiseseName"] as? String
                    {
                        let chronincString = "اسم المرض: \(cname)"
                        self.chronincs.append(chronincString)
                    }
                }
                
                if self.chronincs.isEmpty {
                    print("User has no chronincs.")
                } else {
                    print("chronincs fetched for the user: \(self.chronincs)")
                }
            }
        }
        
        
        // Query for Medications Records related to the User
        guard let userRecordIDStringMed = UserDefaults.standard.string(forKey: "medicationRecord")
        else {
            print("User record ID not found line 213")
            return
        }
        
        let userRecordIDMed = CKRecord.ID(recordName: userRecordIDStringMed)
        // Debug print
        print("UserRecordIDMed: \(userRecordIDMed)")
        
        
        print("UserRecordID: \(userRecordID)")
        
        // Make sure the 'UserID' field is indexed and queryable in your CloudKit Dashboard
        let predicate = NSPredicate(format: "UserID == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
        let query = CKQuery(recordType: "Medications", predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { records, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle the error appropriately
                    print("Error fetching medications records: \(error.localizedDescription)")
                    return
                }
                //
                guard let records = records else {
                    print("No medication records found for user.")
                    return
                }
                //
                for record in records {
                    if let name = record["MedicineName"] as? String,
                       let dose = record["DoseOfMedication"] as? String,
                       let doseUnit = record["DoseUnit"] as? String {
                        
                        let medicationString = "الدواء: \(name)\nالجرعة: \(dose)\nالوحدة: \(doseUnit)"
                        self.medications.append(medicationString)
                    }
                }
                
                if self.medications.isEmpty {
                    print("User has no medications.")
                } else {
                    print("Medications fetched for the user: \(self.medications)")
                }
            }
        }
        
        
        
        // Query for surgeries Records related to the User
        guard let userRecordIDStringSur = UserDefaults.standard.string(forKey: "surgeryRecord")
        else {
            print("User record ID not found line 213 surgeryRecord")
            return
        }
        
        let userRecordIDSur = CKRecord.ID(recordName: userRecordIDStringSur)
        // Debug print
        print("UserRecordIDSur: \(userRecordIDSur)")
        
        
        print("UserRecordID: \(userRecordID)")
        
        // Make sure the 'UserID' field is indexed and queryable in your CloudKit Dashboard
        let predicate2 = NSPredicate(format: "UserID == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
        let query2 = CKQuery(recordType: "PerviousSurgies", predicate: predicate2)
        
        privateDatabase.perform(query2, inZoneWith: nil) { records2, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle the error appropriately
                    print("Error fetching Surgies records: \(error.localizedDescription)")
                    return
                }
                //
                guard let records2 = records2 else {
                    print("No medication records found for user.")
                    return
                }
                //
                for record in records2 {
                    if let sname = record["SurgeryName"] as? String,
                       let year = record["Year"] as? String {
                        let surgeriesString = "اسم العملية: \(sname)\nسنة الإجراء: \(year)"
                        self.surgeries.append(surgeriesString)
                    }
                }
                
                if self.surgeries.isEmpty {
                    print("User has no surgeries.")
                } else {
                    print("surgeries fetched for the user: \(self.surgeries)")
                }
            }
        }
        
        
        
    }// end of the function
    
    
    
    func updatePersonalInformation() {
        print("Updating personal information with:", personal)
        
        
        guard let ageInt = Int(personal[1]) else {
            print(" Age, is not in the correct format.")
            return
        }
        
        guard let IdInt = Int(personal[3]) else {
            print("Id is not in the correct format.")
            return
        }
        
        
        
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        
        guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") else {
            print("User record ID not found")
            return
        }
        
        let userRecordID = CKRecord.ID(recordName: userRecordIDString)
        
        privateDatabase.fetch(withRecordID: userRecordID) { record, error in
            if let record = record, error == nil {
                // Update record fields
                record["FullName"] = personal[0]
                record["Age"] = ageInt
                record["Gender"] = personal[2]
                record["NationalID"] = IdInt
                
                // Save the updated record
                privateDatabase.save(record) { _, error in
                    if let error = error {
                        // Handle error
                        print("Error updating record: \(error.localizedDescription)")
                    } else {
                        // Success
                        print("Record updated successfully")
                    }
                }
            } else {
                print("Error fetching record to update: \(error?.localizedDescription ?? "No error description")")
            }
        }
    }
    
    
    func updateAllergies() {
        print("Updating personal information with:", alergies)
        
        
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        
        guard let userRecordIDString = UserDefaults.standard.string(forKey: "healthInfoRecord") else {
            print("User record health ID not found")
            return
        }
        
        let userRecordID = CKRecord.ID(recordName: userRecordIDString)
        
        privateDatabase.fetch(withRecordID: userRecordID) { record, error in
            if let record = record, error == nil {
                // Update record fields
                record["Allergies"] = alergies
                
                // Save the updated record
                privateDatabase.save(record) { _, error in
                    if let error = error {
                        // Handle error
                        print("Error updating allergy record: \(error.localizedDescription)")
                    } else {
                        // Success
                        print("allergy record updated successfully")
                    }
                }
            } else {
                print("Error fetching allergy record to update: \(error?.localizedDescription ?? "No error description")")
            }
        }
    } //End of update allargies
    
    
    
    func updateMedNotes() {
        print("Updating personal information with:", medicalNotes)
        
        
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        
        guard let userRecordIDString = UserDefaults.standard.string(forKey: "healthInfoRecord") else {
            print("User record health ID not found")
            return
        }
        
        let userRecordID = CKRecord.ID(recordName: userRecordIDString)
        
        privateDatabase.fetch(withRecordID: userRecordID) { record, error in
            if let record = record, error == nil {
                // Update record fields
                record["MedicalNotes"] = medicalNotes
                
                // Save the updated record
                privateDatabase.save(record) { _, error in
                    if let error = error {
                        // Handle error
                        print("Error updating med notes record: \(error.localizedDescription)")
                    } else {
                        // Success
                        print("med notes record updated successfully")
                    }
                }
            } else {
                print("Error fetching med notes record to update: \(error?.localizedDescription ?? "No error description")")
            }
        }
    } //End of update mednotes
    
    
    
    
    
    func prepareSurgeryData(surgeries: [String]){
        surgeryNames = [String]()
        surgeryYears = [String]()
        
        for surgery in surgeries {
            let components = surgery.components(separatedBy: "\n")
            if components.count > 1 {
                let nameComponent = components[0]
                let yearComponent = components[1]
                
                if let nameIndex = nameComponent.range(of: ": ")?.upperBound,
                   let yearIndex = yearComponent.range(of: ": ")?.upperBound {
                    let name = String(nameComponent[nameIndex...])
                    let year = String(yearComponent[yearIndex...])
                    
                    surgeryNames.append(name)
                    surgeryYears.append(year)
                }
            }
        }
        
        
    }//End of prepareSurgeryData
    
    
    func updateSurgeries(surgeryNames: [String], surgeryYears: [String], completion: @escaping (Bool) -> Void) {
        // Ensure there's a user record ID available in UserDefaults
        guard let SurRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") else {
            print("User record ID not found")
            completion(false)
            return
        }
        
        // Set up CloudKit container and database objects
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        let userRecordID = CKRecord.ID(recordName: SurRecordIDString)
        
        // Create a predicate to find surgery records related to the user
        let predicate = NSPredicate(format: "UserID == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
        let query = CKQuery(recordType: "PerviousSurgies", predicate: predicate)
        
        // Perform the query to fetch existing surgery records
        privateDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print("Error fetching surgeries: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Ensure records were fetched
            guard let records = records else {
                print("Error: No records fetched for deletion.")
                completion(false)
                return
            }
            
            // Use a Dispatch Group to synchronize the deletion operations
            let dispatchGroup = DispatchGroup()
            
            // Iterate over fetched records to delete them
            for record in records {
                dispatchGroup.enter() // Enter the group for each deletion operation
                privateDatabase.delete(withRecordID: record.recordID) { _, error in
                    if let error = error {
                        print("Error deleting surgery record: \(error.localizedDescription)")
                        // Handle partial failure if needed
                    }
                    dispatchGroup.leave() // Leave the group once operation completes
                }
            }
            
            // After all deletions have been initiated...
            dispatchGroup.notify(queue: .main) {
                // Track if any errors occurred during creation
                var creationErrors: Bool = false
                
                // Iterate over the new surgery data to create new records
                for (index, name) in surgeryNames.enumerated() {
                    let surgeryRecord = CKRecord(recordType: "PerviousSurgies")
                    surgeryRecord["SurgeryName"] = name
                    surgeryRecord["Year"] = surgeryYears[index]
                    surgeryRecord["UserID"] = CKRecord.Reference(recordID: userRecordID, action: .none)
                    
                    dispatchGroup.enter() // Enter the group for each creation operation
                    privateDatabase.save(surgeryRecord) { _, error in
                        if let error = error {
                            print("Error saving new surgery record: \(error.localizedDescription)")
                            creationErrors = true // Mark that an error occurred
                        }
                        dispatchGroup.leave() // Leave the group once operation completes
                    }
                }
                
                // After all creation operations have been initiated...
                dispatchGroup.notify(queue: .main) {
                    // Call the completion handler with the success status
                    // Success is true if no errors occurred during creation
                    completion(!creationErrors)
                }
            }
        }
    }//end of update surguries on cloud
    
    
    
    func prepareMedicatinData(medications: [String]) {
        MedicationNames = [String]()
        Medicationdoses = [String]()
        Medicationunits = [String]()
        
        for medication in medications {
            let components = medication.components(separatedBy: "\n")
            if components.count > 1 {
                let nameComponent = components[0]
                let doseComponent = components[1]
                let unitComponent = components[2]
                
                if let nameIndex = nameComponent.range(of: ": ")?.upperBound,
                   let doseIndex = doseComponent.range(of: ": ")?.upperBound,
                   let unitIndex = unitComponent.range(of: ": ")?.upperBound{
                    let name = String(nameComponent[nameIndex...])
                    let dose = String(doseComponent[doseIndex...])
                    let unit = String(unitComponent[unitIndex...])
                    
                    MedicationNames.append(name)
                    Medicationdoses.append(dose)
                    Medicationunits.append(unit)
                    
                }
            }
        }
        
        
    }//End of prepareSurgeryData
    
    
    
    
    func updateMedications(MedicationNames: [String], Medicationdoses: [String], Medicationunits: [String], completion: @escaping (Bool) -> Void) {
        // Ensure there's a user record ID available in UserDefaults
        guard let userRecordIDStringMed = UserDefaults.standard.string(forKey: "userRecordID") else {
            print("User record ID not found")
            completion(false)
            return
        }
        
        // Set up CloudKit container and database objects
        let container = CKContainer(identifier: "iCloud.NeedaDB")
        let privateDatabase = container.privateCloudDatabase
        let userRecordID = CKRecord.ID(recordName: userRecordIDStringMed)
        
        // Create a predicate to find surgery records related to the user
        let predicate = NSPredicate(format: "UserID == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
        let query = CKQuery(recordType: "Medications", predicate: predicate)
        
        // Perform the query to fetch existing surgery records
        privateDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print("Error fetching Medications: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Ensure records were fetched
            guard let records = records else {
                print("Error: No Medications records fetched for deletion.")
                completion(false)
                return
            }
            
            // Use a Dispatch Group to synchronize the deletion operations
            let dispatchGroup = DispatchGroup()
            
            // Iterate over fetched records to delete them
            for record in records {
                dispatchGroup.enter() // Enter the group for each deletion operation
                privateDatabase.delete(withRecordID: record.recordID) { _, error in
                    if let error = error {
                        print("Error deleting Medications record: \(error.localizedDescription)")
                        // Handle partial failure if needed
                    }
                    dispatchGroup.leave() // Leave the group once operation completes
                }
            }
            // After all deletions have been initiated...
                        dispatchGroup.notify(queue: .main) {
                            // Track if any errors occurred during creation
                            var creationErrors: Bool = false
                            
                            // Iterate over the new surgery data to create new records
                            for (index, name) in MedicationNames.enumerated() {
                                let medicationRecord = CKRecord(recordType: "Medications")
                                medicationRecord["MedicineName"] = name
                                medicationRecord["DoseOfMedication"] = Medicationdoses[index]
                                medicationRecord["DoseUnit"] = Medicationunits[index]
                                
                                medicationRecord["UserID"] = CKRecord.Reference(recordID: userRecordID, action: .none)
                                
                                dispatchGroup.enter() // Enter the group for each creation operation
                                privateDatabase.save(medicationRecord) { _, error in
                                    if let error = error {
                                        print("Error saving new surgery record: \(error.localizedDescription)")
                                        creationErrors = true // Mark that an error occurred
                                    }
                                    dispatchGroup.leave() // Leave the group once operation completes
                                }
                            }
                            
                            // After all creation operations have been initiated...
                            dispatchGroup.notify(queue: .main) {
                                // Call the completion handler with the success status
                                // Success is true if no errors occurred during creation
                                completion(!creationErrors)
                            }
                        }
                    }
                }//end of update medications on cloud
                
                
                
                
                func prepareChronicData(chronincs: [String]){
                    chronincNames = [String]()
                    
                    
                    for chroninc in chronincs {
                        
                        if let nameIndex = chroninc.range(of: ": ")?.upperBound{
                            let name = String(chroninc[nameIndex...])
                            chronincNames.append(name)
                            
                        }
                    }
                    
                    
                }//end of prepareChronicData
                
                
                func updateChronic(chronincNames: [String], completion: @escaping (Bool) -> Void) {
                    // Ensure there's a user record ID available in UserDefaults
                    guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") else {
                        print("User record ID not found")
                        completion(false)
                        return
                    }
                    
                    // Set up CloudKit container and database objects
                    let container = CKContainer(identifier: "iCloud.NeedaDB")
                    let privateDatabase = container.privateCloudDatabase
                    let userRecordID = CKRecord.ID(recordName: userRecordIDString)
                    
                    // Create a predicate to find surgery records related to the user
                    let predicate = NSPredicate(format: "UserID == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
                    let query = CKQuery(recordType: "ChroincDiseses", predicate: predicate)
                    
                    // Perform the query to fetch existing surgery records
                    privateDatabase.perform(query, inZoneWith: nil) { records, error in
                        if let error = error {
                            print("Error fetching ChroincDiseses: \(error.localizedDescription)")
                            completion(false)
                            return
                        }
                        
                        // Ensure records were fetched
                        guard let records = records else {
                            print("Error: No ChroincDiseses records fetched for deletion.")
                            completion(false)
                            return
                        }
                        
                        // Use a Dispatch Group to synchronize the deletion operations
                        let dispatchGroup = DispatchGroup()
                        
                        // Iterate over fetched records to delete them
                        for record in records {
                            dispatchGroup.enter() // Enter the group for each deletion operation
                            privateDatabase.delete(withRecordID: record.recordID) { _, error in
                                if let error = error {
                                    print("Error deleting ChroincDiseses record: \(error.localizedDescription)")
                                    // Handle partial failure if needed
                                }
                                dispatchGroup.leave() // Leave the group once operation completes
                            }
                        }
                        
                        // After all deletions have been initiated...
                        dispatchGroup.notify(queue: .main) {
                            // Track if any errors occurred during creation
                            var creationErrors: Bool = false
                            
                            // Iterate over the new surgery data to create new records
                            for (index, name) in chronincNames.enumerated() {
                                let chronicRecord = CKRecord(recordType: "ChroincDiseses")
                                chronicRecord["DiseseName"] = name
                                
                                
                                chronicRecord["UserID"] = CKRecord.Reference(recordID: userRecordID, action: .none)
                                
                                dispatchGroup.enter() // Enter the group for each creation operation
                                privateDatabase.save(chronicRecord) { _, error in
                                    if let error = error {
                                        print("Error saving new chronic record: \(error.localizedDescription)")
                                        creationErrors = true // Mark that an error occurred
                                    }
                                    dispatchGroup.leave() // Leave the group once operation completes
                                }
                            }
                            
                            // After all creation operations have been initiated...
                            dispatchGroup.notify(queue: .main) {
                                // Call the completion handler with the success status
                                // Success is true if no errors occurred during creation
                                completion(!creationErrors)
                            }
                        }
                    }
                }//end of update chronic on cloud
                
                
                
                
                
                func addNewMedication(name: String, dose: String, unit: String) {
                    let container = CKContainer(identifier: "iCloud.NeedaDB")
                    let privateDatabase = container.privateCloudDatabase
                    
                    guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") else {
                        print("User record ID not found")
                        return
                    }
                    
                    let medicationRecord = CKRecord(recordType: "Medications")
                    medicationRecord["MedicineName"] = name
                    medicationRecord["DoseOfMedication"] = dose
                    medicationRecord["DoseUnit"] = unit
                    medicationRecord["UserID"] = CKRecord.Reference(recordID: CKRecord.ID(recordName: userRecordIDString), action: .none)
                    
                    privateDatabase.save(medicationRecord) { _, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("Error saving new medication record: \(error.localizedDescription)")
                            } else {
                                print("New medication added successfully")
                                let newMedicationString = "الدواء: \(name)\nالجرعة: \(dose)\nالوحدة: \(unit)"
                                self.medications.append(newMedicationString)
                            }
                        }
                    }
                } //end of adding medication
                
                
                
                func addNewSurgury(name: String, year: String) {
                    let container = CKContainer(identifier: "iCloud.NeedaDB")
                    let privateDatabase = container.privateCloudDatabase
                    
                    guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") else {
                        print("User record ID not found")
                        return
                    }
                    
                    let surgeriesRecord = CKRecord(recordType: "PerviousSurgies")
                    surgeriesRecord["SurgeryName"] = name
                    surgeriesRecord["Year"] = year
                    surgeriesRecord["UserID"] = CKRecord.Reference(recordID: CKRecord.ID(recordName: userRecordIDString), action: .none)
                    
                    privateDatabase.save(surgeriesRecord) { _, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("Error saving new surgery record: \(error.localizedDescription)")
                            } else {
                                print("New medication added successfully")
                                let newSurgeryString = " اسم العملية: \(name)\nسنة الإجراء: \(year)"
                                self.surgeries.append(newSurgeryString)
                            }
                        }
                    }
                } //end of adding Surgery
                
                
                
                func addNewChroninc(name: String) {
                    let container = CKContainer(identifier: "iCloud.NeedaDB")
                    let privateDatabase = container.privateCloudDatabase
                    
                    guard let userRecordIDString = UserDefaults.standard.string(forKey: "userRecordID") else {
                        print("User record ID not found")
                        return
                    }
                    
                    let ChroincDisesesRecord = CKRecord(recordType: "ChroincDiseses")
                    ChroincDisesesRecord["DiseseName"] = name
                    ChroincDisesesRecord["UserID"] = CKRecord.Reference(recordID: CKRecord.ID(recordName: userRecordIDString), action: .none)
                    
                    privateDatabase.save(ChroincDisesesRecord) { _, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("Error saving new surgery record: \(error.localizedDescription)")
                            } else {
                                print("New medication added successfully")
                                let newchronincString = " اسم المرض: \(name)"
                                self.chronincs.append(newchronincString)
                            }
                        }
                    }
                } //end of adding Surgery
                
            } // End of struct NewmedicalHistory

            // Custom health card view with icon and value.
            // End of HealthCardTwo



            //struct HealthHistoryCard: View {
            //    var title: String
            //    var value: String
            //    var iconName: String
            //    var color: Color
            //
            //    var body: some View {
            //        VStack(alignment: .trailing, spacing: 10) {
            //            Text(title)
            //                .font(.headline)
            //                .padding(.top)
            //
            //            Image(systemName: iconName)
            //                .imageScale(.large)
            //                .foregroundColor(color)
            //                .padding(.bottom)
            //
            //            Text(value)
            //                .font(.body)
            //                .padding(.bottom)
            //        }
            //        .frame(width: 180, height: 180)
            //        .background(Color.white)
            //        .cornerRadius(20)
            //        .shadow(radius: 10)
            //    }
            //
            //
            //
            //} // End of HealthHistoryCard



            struct HealthCardPersonaInfo: View {
                var title: String
                var personal: [String] // This array should contain the name, age, and gender in order.
                var graphName: String
                var color: Color
                
                var body: some View {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(title)
                            .font(.system(size: 30))
                            .padding(.bottom, 5)
                            .padding(.leading, 60)
                            .foregroundColor( .red)
                        
                        
                        ScrollView {
                            VStack(alignment: .leading, spacing: 5) {
                                // Display Name with title
                                if personal.indices.contains(0) {
                                    Text("الاسم: \(personal[0])")
                                        .font(.subheadline)
                                        .padding(.vertical, 2)
                                        .font(.system(size: 18))
                                    
                                    // Display Id with title
                                    if personal.indices.contains(3) {
                                        Text("الهوية الوطنية: \(personal[3])")
                                            .font(.subheadline)
                                            .padding(.vertical, 2)
                                            .font(.system(size: 18))
                                        
                                    }
                                }
                                // Display Age with title
                                if personal.indices.contains(1) {
                                    Text("العمر: \(personal[1])")
                                        .font(.subheadline)
                                        .padding(.vertical, 2)
                                        .font(.system(size: 18))
                                    
                                }
                                // Display Gender with title
                                if personal.indices.contains(2) {
                                    Text("الجنس: \(personal[2])")
                                        .font(.subheadline)
                                        .padding(.vertical, 2)
                                        .font(.system(size: 18))
                                    
                                }
                                
                            }
                            .padding(.horizontal)
                        }
                        .frame(minHeight: 100)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Image(systemName: graphName)
                                .imageScale(.large)
                                .foregroundColor(.red)
                                .padding(.top , -175)
                                .padding(.leading, -330)
                                .font(.system(size: 25))
                            
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                }
            }



            struct HealthCardSurgeries: View {
                var title: String
                var surgeries: [String] // This should be an array of medication descriptions
                var color: Color
                
                var body: some View {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(title)
                            .font(.system(size: 30))
                            .foregroundColor( .red)
                            .padding(.top, 10)
                            .padding(.leading, 75)
                        
                        ScrollView {
                            ForEach(surgeries, id: \.self) { surgery in
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(surgery) // The string includes new lines and labels
                                        .font(.subheadline)
                                        .padding(.vertical, 2)
                                        .font(.system(size: 18))
                                    
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(minHeight: 100)
                        
                        
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Image("hospital-bed")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .imageScale(.large)
                                .foregroundColor(.red)
                                .padding(.top , -190)
                                .padding(.leading, -330)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                }
                
            }

            struct HealthCardChronic: View {
                var title: String
                var chronincs: [String]
                var color: Color
                
                var body: some View {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(title)
                            .font(.system(size: 30))
                            .foregroundColor( .red)
                            .padding(.top, 10)
                            .padding(.leading, 75)
                        
                        ScrollView {
                            ForEach(chronincs, id: \.self) { chroninc in
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(chroninc) // The string includes new lines and labels
                                        .font(.subheadline)
                                        .padding(.vertical, 2)
                                        .font(.system(size: 23))
                                    
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(minHeight: 100)
                        
                        
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Image("lungs.fill")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .imageScale(.large)
                                .foregroundColor(.red)
                                .padding(.top , -190)
                                .padding(.leading, -330)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                }
                
            }







            struct UpdateView: View {
                
                @Binding var personal: [String]
                let onApply: () -> Void
                @Environment(\.presentationMode) var presentationMode
                
                @State private var errorMessage: String = ""
                
                var body: some View {
                    NavigationView {
                        Form {
                            TextField("Name", text: $personal[0])
                            TextField("Age", text: $personal[1])
                                .keyboardType(.numberPad)
                            TextField("Gender", text: $personal[2])
                            TextField("ID", text: $personal[3])
                                .keyboardType(.numberPad)
                            
                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                            }
                            
                            Button(action: {
                                // Perform validation when the button is pressed
                                if validateInputs() {
                                    self.onApply() // Proceed if validation passes
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }) {
                                Text("Apply Updates")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .padding(.top, 10)
                        }
                        .navigationBarTitle("تعديل المعلومات الشخصية", displayMode: .inline)
                    }
                }
                
                private func validateInputs() -> Bool {
                    guard validateName(personal[0]),
                          validateAge(personal[1]),
                          validateGender(personal[2]),
                          validateID(personal[3]) else {
                        // If any validation fails, errorMessage is already set by the failing function
                        return false
                    }
                    
                    // Reset errorMessage if all validations pass
                    errorMessage = ""
                    return true
                }
                
                private func validateName(_ name: String) -> Bool {
                    if name.isEmpty || !name.allSatisfy({ $0.isLetter }) {
                        errorMessage = "يجب أن يحتوي الاسم على أحرف فقط ولا يمكن أن يكون فارغا."
                        return false
                    }
                    return true
                }
                
                private func validateAge(_ ageString: String) -> Bool {
                    guard let age = Int(ageString), age > 0, age <= 100 else {
                        errorMessage = "أدخل عمرًا صالحًا بين ١٨ -١٠٠"
                        return false
                    }
                    return true
                }
                
                private func validateGender(_ gender: String) -> Bool {
                    if gender.isEmpty {
                        errorMessage = "لا يمكن أن يكون الجنس فارغًا"
                        return false
                    }
                    return true
                }
                
                private func validateID(_ id: String) -> Bool {
                    let idRegex = "^[0-9]{10}$"
                    if !NSPredicate(format: "SELF MATCHES %@", idRegex).evaluate(with: id) {
                        errorMessage = "يجب أن يكون رقم الهوية مكونًا من 10 أرقام."
                        return false
                    }
                    return true
                }
            }



            struct UpdateViewAllergy: View {
                @Binding var allergies: String
                let onApply: () -> Void
                @Environment(\.presentationMode) var presentationMode

                @State private var errorMessage: String = ""

                var body: some View {
                    NavigationView {
                        Form {
                            TextField("Allergies", text: $allergies)
                                .onChange(of: allergies) { _ in validateAllergies() }
                            
                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                            }
                            
                            Button(action: {
                                if validateAllergies() {
                                    self.onApply() // This calls the update function passed
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }) {
                                Text("Apply Updates")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                        .navigationBarTitle("تعديل الحساسية", displayMode: .inline)
                        .navigationBarItems(trailing: Button("إلغاء") {
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
                }

                private func validateAllergies() -> Bool {
                    if allergies.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        errorMessage = "لا يمكن أن يكون حقل الحساسية فارغاً."
                        return false
                    } else {
                        errorMessage = ""
                        return true
                    }
                }
            }



            struct UpdateViewnotes: View {
                @Binding var medicalNotes: String
                let onApply: () -> Void
                @Environment(\.presentationMode) var presentationMode

                @State private var errorMessage: String = ""

                var body: some View {
                    NavigationView {
                        Form {
                            TextField("Medical Notes", text: $medicalNotes)
                                .onChange(of: medicalNotes) { newValue in
                                    validateMedicalNotes(newValue)
                                }

                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .padding()
                            }

                            Button(action: {
                                if validateInput() {
                                    self.onApply() // This calls the update function passed
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }) {
                                Text("Apply Updates")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                        .navigationBarTitle("تعديل الملاحظات الطبية", displayMode: .inline)
                        .navigationBarItems(trailing: Button("Done") {
                            self.presentationMode.wrappedValue.dismiss()
                        })
                    }
                }

                private func validateMedicalNotes(_ notes: String) {
                    if notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        errorMessage = "الملاحظات الطبية لا يجب أن تكون فارغة"
                    } else {
                        errorMessage = ""
                    }
                }

                private func validateInput() -> Bool {
                    return errorMessage.isEmpty
                }
            }
             //end of update notes struct




            struct UpdateSurgeriesView: View {
                @Binding var surgeryNames: [String]
                @Binding var surgeryYears: [String]
                @Binding var surgeries: [String]
                let onApply: () -> Void
                @Environment(\.presentationMode) var presentationMode

                @State private var errorMessage: String = ""

                var body: some View {
                    NavigationView {
                        List {
                            ForEach(Array(surgeryNames.indices), id: \.self) { index in
                                TextField("Name of surgery", text: $surgeryNames[index])
                                TextField("Year of surgery", text: $surgeryYears[index])
                                    .keyboardType(.numberPad) // Ensure numeric input for year
                            }
                            .onDelete(perform: deleteSurgery)

                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                            }

                            Button(action: {
                                if validateSurgeries() {
                                    surgeries.removeAll()
                                    for index in surgeryNames.indices {
                                        let surgeryString = "اسم العملية: \(surgeryNames[index])\nسنة الإجراء: \(surgeryYears[index])"
                                        surgeries.append(surgeryString)
                                    }
                                    self.onApply() // This calls the update function passed
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }) {
                                Text("Apply Updates")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                        .navigationBarTitle("تعيل العمليات", displayMode: .inline)
                        .navigationBarItems(trailing: Button("تم") {
                            self.presentationMode.wrappedValue.dismiss()
                        })
                    }
                }

                private func deleteSurgery(at offsets: IndexSet) {
                    surgeryNames.remove(atOffsets: offsets)
                    surgeryYears.remove(atOffsets: offsets)
                }

                private func validateSurgeries() -> Bool {
                    for (name, year) in zip(surgeryNames, surgeryYears) {
                        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || year.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            errorMessage = "اسم العملية والسنة يجب ألا يكونا فارغين."
                            return false
                        }
                        if let yearInt = Int(year), yearInt < 1900 || yearInt > Calendar.current.component(.year, from: Date()) {
                            errorMessage = "أدخل سنة صالحة للعمليات الجراحية."
                            return false
                        }
                    }
                    errorMessage = ""
                    return true
                }
            }





            struct UpdateMedicationView: View {
                @Binding var medications: [String]
                @Binding var MedicationNames: [String]
                @Binding var Medicationdoses: [String]
                @Binding var Medicationunits: [String]
                let onApply: () -> Void
                @Environment(\.presentationMode) var presentationMode
                
                @State private var errorMessage: String = ""
                
                var body: some View {
                    NavigationView {
                        Form {
                            ForEach(MedicationNames.indices, id: \.self) { index in
                                TextField("Name of Medication", text: $MedicationNames[index])
                                TextField("Dose of Medication", text: $Medicationdoses[index])
                                    .keyboardType(.decimalPad)
                                TextField("Unit of Medication", text: $Medicationunits[index])
                            }
                            
                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                            }
                            
                            Button(action: {
                                // Perform validation when the button is pressed
                                if validateInputs() {
                                    medications.removeAll()
                                    for index in MedicationNames.indices {
                                        let medicationString = "الدواء: \(MedicationNames[index])\nالجرعة: \(Medicationdoses[index])\nالوحدة: \(Medicationunits[index])"
                                        medications.append(medicationString)
                                    }
                                    self.onApply() // This should call a method to update CloudKit
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }) {
                                Text("Apply Updates")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                        .navigationBarTitle("Update Medications", displayMode: .inline)
                        .navigationBarItems(trailing: Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
                }
                
                private func validateInputs() -> Bool {
                    for index in MedicationNames.indices {
                        if !validateMedicationName(MedicationNames[index]) ||
                           !validateDose(Medicationdoses[index]) ||
                           !validateUnit(Medicationunits[index]) {
                            // errorMessage is already set by the failing validation function
                            return false
                        }
                    }
                    // Reset errorMessage if all validations pass
                    errorMessage = ""
                    return true
                }
                
                private func validateMedicationName(_ name: String) -> Bool {
                    if name.isEmpty {
                        errorMessage = "لا يمكن أن يكون اسم الدواء فارغًا."
                        return false
                    }
                    return true
                }
                
                private func validateDose(_ dose: String) -> Bool {
                    guard let doseNumber = Double(dose), doseNumber > 0 else {
                        errorMessage = "يجب أن تكون الجرعة رقمًا موجبًا."
                        return false
                    }
                    return true
                }
                
                private func validateUnit(_ unit: String) -> Bool {
                    if unit.isEmpty {
                        errorMessage = "لا يمكن أن تكون الوحدة فارغة."
                        return false
                    }
                    return true
                }
            }


            struct UpdateChronicView: View {
                @Binding var chronincs: [String]
                @Binding var chronincNames: [String]
                
                let onApply: () -> Void
                @Environment(\.presentationMode) var presentationMode

                @State private var errorMessage: String = ""

                var body: some View {
                    NavigationView {
                        List {
                            ForEach(Array(chronincNames.indices), id: \.self) { index in
                                TextField("Name of disease", text: $chronincNames[index])
                                    .onChange(of: chronincNames[index]) { newValue in
                                        validateChronicName(newValue, at: index)
                                    }
                            }
                            .onDelete(perform: deleteChronic)

                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                            }

                            Button(action: {
                                if validateChronics() {
                                    chronincs.removeAll()
                                    for name in chronincNames {
                                        let chronicString = "اسم المرض: \(name)"
                                        chronincs.append(chronicString)
                                    }
                                    self.onApply() // This calls the update function passed to CloudKit
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }) {
                                Text("Apply Updates")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                        .navigationBarTitle("تعديل الأمراض المزمنة", displayMode: .inline)
                        .navigationBarItems(trailing: Button("تم") {
                            self.presentationMode.wrappedValue.dismiss()
                        })
                    }
                }

                private func deleteChronic(at offsets: IndexSet) {
                    chronincNames.remove(atOffsets: offsets)
                }

                private func validateChronics() -> Bool {
                    for name in chronincNames {
                        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            errorMessage = "يجب ألا تكون أسماء الأمراض المزمنة فارغة."
                            return false
                        }
                    }
                    errorMessage = ""
                    return true
                }

                private func validateChronicName(_ name: String, at index: Int) {
                    // Here you can add any specific validation for each chronic disease name
                    // For example, checking for non-alphanumeric characters or length
                    // This is just a placeholder for any specific validation you might want to add
                    if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        errorMessage = "اسم المرض المزمن في الخانة \(index + 1) فارغ."
                    } else {
                        errorMessage = ""
                    }
                }
            }
            //end of update chronic



            struct AddMedicationView: View {
                @Environment(\.presentationMode) var presentationMode
                var onAdd: (String, String, String) -> Void
                
                @State private var medicationName: String = ""
                @State private var medicationDose: String = ""
                @State private var medicationUnit: String = ""
                
                var body: some View {
                    NavigationView {
                        Form {
                            TextField("Medication Name", text: $medicationName)
                            TextField("Dose", text: $medicationDose)
                            TextField("Unit", text: $medicationUnit)
                            
                            Button("Add Medication") {
                                onAdd(medicationName, medicationDose, medicationUnit)
                                presentationMode.wrappedValue.dismiss()
                            }
                            .disabled(medicationName.isEmpty || medicationDose.isEmpty || medicationUnit.isEmpty)
                        }
                        .navigationBarTitle("Add New Medication", displayMode: .inline)
                        
                        .navigationBarItems(trailing: Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
                }
            }




            struct AddSurgyryView: View {
                @Environment(\.presentationMode) var presentationMode
                var onSurgeryAdd: (String, String) -> Void
                
                @State private var surgeryName: String = ""
                @State private var surgeryYear: String = ""
                
                var body: some View {
                    NavigationView {
                        Form {
                            TextField("Surgery Name", text: $surgeryName)
                            TextField("Year", text: $surgeryYear)
                            
                            Button("Add Surgery") {
                                onSurgeryAdd(surgeryName, surgeryYear)
                                presentationMode.wrappedValue.dismiss()
                            }
                            .disabled(surgeryName.isEmpty || surgeryYear.isEmpty)
                        }
                        .navigationBarTitle("Add New Surgery", displayMode: .inline)
                        
                        .navigationBarItems(trailing: Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
                }
            }



            struct AddChronincView: View {
                @Environment(\.presentationMode) var presentationMode
                var onChronincAdd: (String) -> Void
                
                @State private var ChronincName: String = ""
                
                var body: some View {
                    NavigationView {
                        Form {
                            TextField("chrononc Name", text: $ChronincName)
                            
                            
                            Button("Add Chroninc") {
                                onChronincAdd(ChronincName)
                                presentationMode.wrappedValue.dismiss()
                            }
                            .disabled(ChronincName.isEmpty)
                        }
                        .navigationBarTitle("Add New chroninc", displayMode: .inline)
                        
                        .navigationBarItems(trailing: Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
                }
            }



            struct DeleteMedicationView: View {
                @Binding var medications: [String]
                @State private var selectedMedications: Set<String> = []
                @Environment(\.presentationMode) var presentationMode
                
                var body: some View {
                    NavigationView {
                        List(medications, id: \.self, selection: $selectedMedications) { medication in
                            Text(medication)
                        }
                        .navigationBarTitle(Text("Delete Medications"), displayMode: .inline)
                        .navigationBarItems(
                            leading: Button("Cancel") {
                                presentationMode.wrappedValue.dismiss()
                            },
                            trailing: Button("Delete") {
                                deleteSelectedMedications()
                            }
                                .foregroundColor(selectedMedications.isEmpty ? .gray : .red)
                                .disabled(selectedMedications.isEmpty)
                        )
                    }
                }
                
                func deleteSelectedMedications() {
                    for fullMedicationString in selectedMedications {
                        if let index = medications.firstIndex(of: fullMedicationString) {
                            medications.remove(at: index)
                            // Extract the medication name from the full string
                            let medicationName = extractMedicationName(from: fullMedicationString)
                            // Call the method to delete from CloudKit
                            deleteMedicationFromCloud(medication: medicationName) { success in
                                print("Deletion completion with success: \(success)")
                            }
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                
                func extractMedicationName(from fullMedicationString: String) -> String {
                    let components = fullMedicationString.components(separatedBy: "\n")
                    if let nameComponent = components.first(where: { $0.starts(with: "الدواء:") }) {
                        let nameParts = nameComponent.components(separatedBy: ": ")
                        if nameParts.count > 1 {
                            return nameParts[1] // Return the part after "الدواء:"
                        }
                    }
                    return "" // Return an empty string if the name isn't found
                }
                
                // Method to delete a medication from CloudKit
                func deleteMedicationFromCloud(medication: String , completion: @escaping (Bool) -> Void) {
                    guard let userRecordIDStringMed = UserDefaults.standard.string(forKey: "userRecordID") else {
                        print("User record ID not found")
                        completion(false)
                        return
                    }
                    
                    // Set up CloudKit container and database objects
                    let container = CKContainer(identifier: "iCloud.NeedaDB")
                    let privateDatabase = container.privateCloudDatabase
                    let userRecordID = CKRecord.ID(recordName: userRecordIDStringMed)
                    
                    // Create a predicate to find surgery records related to the user
                    let userPredicate = NSPredicate(format: "UserID == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
                    let medicationPredicate = NSPredicate(format: "MedicineName == %@", medication)
                    
                    let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [userPredicate, medicationPredicate])
                    
                    // Now use `combinedPredicate` in your query
                    let query = CKQuery(recordType: "Medications", predicate: combinedPredicate)
                    
                    privateDatabase.perform(query, inZoneWith: nil) { records, error in
                        guard let records = records, error == nil
                        else {
                            print("Error fetching medication records: \(error!.localizedDescription)")
                            return
                        }
                        
                        
                        for record in records {
                            privateDatabase.delete(withRecordID: record.recordID) { recordID, error in
                                if let error = error {
                                    print("Error deleting record: \(error.localizedDescription)")
                                } else {
                                    print("Medication record deleted successfully")
                                }
                            }
                        }
                    }
                }
            } //end of medication delete






            struct DeleteSurgeryView: View {
                @Binding var surgeries: [String]
                @State private var selectedSurgeries: Set<String> = []
                @Environment(\.presentationMode) var presentationMode
                
                var body: some View {
                    NavigationView {
                        List(surgeries, id: \.self, selection: $selectedSurgeries) { surgery in
                            Text(surgery)
                        }
                        .navigationBarTitle(Text("Delete surgery"), displayMode: .inline)
                        .navigationBarItems(
                            leading: Button("Cancel") {
                                presentationMode.wrappedValue.dismiss()
                            },
                            trailing: Button("Delete") {
                                deleteSelectedSurgeries()
                            }
                                .foregroundColor(selectedSurgeries.isEmpty ? .gray : .red)
                                .disabled(selectedSurgeries.isEmpty)
                        )
                    }
                }
                
                func deleteSelectedSurgeries() {
                    for fullsurgeryString in selectedSurgeries {
                        if let index = surgeries.firstIndex(of: fullsurgeryString) {
                            surgeries.remove(at: index)
                            
                            let surgeryName = extractSurgeryName(from: fullsurgeryString)
                            
                            deleteSurgeriesFromCloud(surgery: surgeryName) { success in
                                print("Deletion completion with success: \(success)")
                            }
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                
                func extractSurgeryName(from fullSurgeryString: String) -> String {
                    let components = fullSurgeryString.components(separatedBy: "\n")
                    if let nameComponent = components.first(where: { $0.starts(with: "اسم العملية:") }) {
                        let nameParts = nameComponent.components(separatedBy: ": ")
                        if nameParts.count > 1 {
                            return nameParts[1]
                        }
                    }
                    return ""
                }
                
                // Method to delete a medication from CloudKit
                func deleteSurgeriesFromCloud(surgery: String , completion: @escaping (Bool) -> Void) {
                    guard let userRecordIDStringMed = UserDefaults.standard.string(forKey: "userRecordID") else {
                        print("User record ID not found")
                        completion(false)
                        return
                    }
                    
                    // Set up CloudKit container and database objects
                    let container = CKContainer(identifier: "iCloud.NeedaDB")
                    let privateDatabase = container.privateCloudDatabase
                    let userRecordID = CKRecord.ID(recordName: userRecordIDStringMed)
                    
                    // Create a predicate to find surgery records related to the user
                    let userPredicate = NSPredicate(format: "UserID == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
                    let surgeryPredicate = NSPredicate(format: "SurgeryName == %@", surgery)
                    
                    let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [userPredicate, surgeryPredicate])
                    
                    // Now use `combinedPredicate` in your query
                    let query = CKQuery(recordType: "PerviousSurgies", predicate: combinedPredicate)
                    
                    privateDatabase.perform(query, inZoneWith: nil) { records, error in
                        guard let records = records, error == nil
                        else {
                            print("Error fetching surgery records: \(error!.localizedDescription)")
                            return
                        }
                        
                        for record in records {
                            privateDatabase.delete(withRecordID: record.recordID) { recordID, error in
                                if let error = error {
                                    print("Error deleting record: \(error.localizedDescription)")
                                } else {
                                    print("surgery record deleted successfully")
                                }
                            }
                        }
                    }
                }
            }//end of delete surgery




            struct DeleteChronicView: View {
                @Binding var chronincs: [String]
                @State private var selectedChronincs: Set<String> = []
                @Environment(\.presentationMode) var presentationMode
                
                var body: some View {
                    NavigationView {
                        List(chronincs, id: \.self, selection: $selectedChronincs) { medication in
                            Text(medication)
                        }
                        .navigationBarTitle(Text("Delete Chronincs"), displayMode: .inline)
                        .navigationBarItems(
                            leading: Button("Cancel") {
                                presentationMode.wrappedValue.dismiss()
                            },
                            trailing: Button("Delete") {
                                deleteSelectedChronicDiseases()
                            }
                                .foregroundColor(selectedChronincs.isEmpty ? .gray : .red)
                                .disabled(selectedChronincs.isEmpty)
                        )
                    }
                }
                
                func deleteSelectedChronicDiseases() {
                    for fullChronicString in selectedChronincs {
                        if let index = chronincs.firstIndex(of: fullChronicString) {
                            chronincs.remove(at: index)
                            let chronicName = extractChronicName(from: fullChronicString)
                            deleteChronicFromCloud(chronic: chronicName) { success in
                                print("Deletion completion with success: \(success)")
                            }
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                
                func extractChronicName(from fullChronicString: String) -> String {
                    let components = fullChronicString.components(separatedBy: "\n")
                    if let nameComponent = components.first(where: { $0.starts(with: "اسم المرض:") }) {
                        let nameParts = nameComponent.components(separatedBy: ": ")
                        if nameParts.count > 1 {
                            return nameParts[1]
                        }
                    }
                    return ""
                }
                
                // Method to delete a chronic from CloudKit
                func deleteChronicFromCloud(chronic: String , completion: @escaping (Bool) -> Void) {
                    guard let userRecordIDStringMed = UserDefaults.standard.string(forKey: "userRecordID") else {
                        print("User record ID not found")
                        completion(false)
                        return
                    }
                    
                    // Set up CloudKit container and database objects
                    let container = CKContainer(identifier: "iCloud.NeedaDB")
                    let privateDatabase = container.privateCloudDatabase
                    let userRecordID = CKRecord.ID(recordName: userRecordIDStringMed)
                    
                    // Create a predicate to find surgery records related to the user
                    let userPredicate = NSPredicate(format: "UserID == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
                    let medicationPredicate = NSPredicate(format: "DiseseName == %@", chronic)
                    
                    let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [userPredicate, medicationPredicate])
                    
                    // Now use `combinedPredicate` in your query
                    let query = CKQuery(recordType: "ChroincDiseses", predicate: combinedPredicate)
                    
                    privateDatabase.perform(query, inZoneWith: nil) { records, error in
                        guard let records = records, error == nil
                        else {
                            print("Error fetching Chroinc Diseses records: \(error!.localizedDescription)")
                            return
                        }
                        
                        for record in records {
                            privateDatabase.delete(withRecordID: record.recordID) { recordID, error in
                                if let error = error {
                                    print("Error deleting record: \(error.localizedDescription)")
                                } else {
                                    print("Chroinc Diseses record deleted successfully")
                                }
                            }
                        }
                    }
                }
            }//end of chronic delete

            struct NewViewHealthInfoPage_Previews: PreviewProvider {
                static var previews: some View {
                    NewmedicalHistory()
                }
            } // End of NewViewHealthInfoPage_Previews
