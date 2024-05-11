






//
//  otp.swift
//  NeedaApp
//
//  Created by Ruba Kef on 17/10/1445 AH.
//

import SwiftUI
import FirebaseFunctions

struct otp: View {
    //email OTP
    @State private var emailError = ""
    @State private var email = ""
    @StateObject var otpModel:OTPViewModel = .init()
    //otp field activation
    @FocusState var activeField: OTPField?
    
    var body: some View {
        Group {
            HStack {
                Text("البريد الإلكتروني الوزاري")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("*")
                    .foregroundColor(.red)
                    .padding(.leading, -180)
            }
            
            TextField("", text: $email, onEditingChanged: { isEditing in
                if !isEditing {
                    emailError = validateEmail(email) ? "" : "أدخل بريد إلكتروني صحيح"
                }
            })
            .foregroundColor(.black)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .environment(\.layoutDirection, .rightToLeft)
            
            if !emailError.isEmpty {
                Text(emailError)
                    .foregroundColor(.red)
            }
            
            
        }
        .environment(\.layoutDirection, .rightToLeft)
        
        Group{
            VStack{
                OTPField()
                
                
                Button(action: {
                    self.requestOTP()
                }) {
                    Text("أرسل")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical,12)
                        .frame( maxWidth: .infinity)
                        .background{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.blue)                }
                        .disabled(email.isEmpty || !validateEmail(email))
                    
                    
                    
                    
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                .navigationTitle("otp please")
                .onChange(of: otpModel.otpFields){ newValue in
                    OTPCondition(value: newValue)
                }
                
                Button("Verify OTP") {
                    let otpString = otpModel.otpFields.joined()
                    verifyOTP(otp: otpString)
                }
                .disabled(chackState())
                .opacity(chackState() ? 0.4 : 1)
                .padding(.vertical)
                
                HStack(spacing: 12){
                    Text("ألم يصلك الرمز؟")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Button("أرسل مرة أخرى"){
                        
                    }
                    .font(.callout)
                    .foregroundColor(.blue)
                    
                    
                }.frame( maxWidth: .infinity)
                    .environment(\.layoutDirection, .rightToLeft)
            }
        }
        
    }
    
    
    //OTP Field
      @ViewBuilder
      func OTPField()->some View{
          HStack(spacing: 14) {
              ForEach(0..<6,id: \.self){index in
                  VStack(spacing: 8){
                      TextField("", text: $otpModel.otpFields[index])
                          .keyboardType(.numberPad)
                          .textContentType(.oneTimeCode)
                          .multilineTextAlignment(.center)
                          .focused($activeField, equals: activeStateForIndex(index: index))
                      
                      Rectangle()
                          .fill(activeField == activeStateForIndex(index: index) ? .blue : .gray.opacity(0.3))
                          .frame(height: 4)
                  }
                  .frame(width: 40)
              }
              
          }
      }
      
      //active stste
      func activeStateForIndex(index: Int)->OTPField{
          switch index{
          case 0: return .field1
          case 1: return .field2
          case 2: return .field3
          case 3: return .field4
          case 4: return .field5
          default: return .field6
          }
      }
      
      
    // conditions for otp field & limiting only one text
      func OTPCondition(value: [String]){
          //moving next field if current field is typed
          for index in 0..<5{
              if value[index].count == 1 && activeStateForIndex(index: index) == activeField{
                  activeField = activeStateForIndex(index: index + 1)
              }
              
          }
          
          //moving back if current is empty and previos is not
          for index in 0...5{
              if index != 0{
                  if value[index].isEmpty && !value[index-1].isEmpty{
                      activeField = activeStateForIndex(index: index - 1)
                      
                  }}
          }

          
          
          for index in 0..<6{
              if value[index].count > 1{
                  otpModel.otpFields[index] = String(value[index].last!)
                  
              }
          }
          
      }
    
    
    
    
    func chackState()->Bool{
        for index in 0..<6{
            if otpModel.otpFields[index].isEmpty{return true}

            }
        return false
        }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailValidation = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailValidation.evaluate(with: email)
    }
    
    
    func requestOTP() {
        let functions = Functions.functions()
        functions.httpsCallable("sendEmailOTP").call(["email": self.email]
        ) { result, error in
            if let error = error {
                // Handle the error
                print(error.localizedDescription)
            } else {
                // OTP sent
                print("OTP sent to email.")
            }
        }
    }
    
    func verifyOTP(otp: String) {
        let functions = Functions.functions()
        functions.httpsCallable("verifyEmailOTP").call(["email": self.email, "otp": otp]) { result, error in
            if let error = error {
                // Handle the error
                print(error.localizedDescription)
            } else if let result = result?.data as? [String: Any], let success = result["success"] as? Bool {
                if success {
                    print("Yeah!")
                } else {
                    print("Incorrect OTP or it has expired.")
                }
            }
        }
    }


    
    }


#Preview {
    otp()
}
////focus state enum
//enum OTPField{
//    case field1
//    case field2
//    case field3
//    case field4
//    case field5
//    case field6
//
//}
