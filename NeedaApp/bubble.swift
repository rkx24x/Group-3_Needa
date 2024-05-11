//
//  bubble.swift
//  NeedaApp
//
//  Created by Reham  on 06/09/1445 AH.
//
import SwiftUI
//
//struct InfoButtonView: View {
//    @Binding var isBubbleVisible: Bool
//    @Binding var bubbleText: String
//    
//    var body: some View {
//        Image(systemName: "info.circle")
//            .resizable()
//            .frame(width: 15, height: 15)
//            .onTapGesture {
//                isBubbleVisible.toggle()
//            }
//            .overlay(
//                Group {
//                    if isBubbleVisible {
//                        BubbleView(text: $bubbleText)
//                    }
//                }
//            )
//            .offset(x:150, y:1)
//    }
//}
//
//struct BubbleView: View {
//    @Binding var text: String
//
//    var body: some View {
//        RoundedRectangle(cornerRadius: 10)
//            .fill(Color(red: 1.0, green: 0.388, blue: 0.278))
//            .frame(width: 160, height: 60)
//            .overlay(
//                Text(text)
//                    .foregroundColor(.white)
//                    .padding()
//            )
//        .offset(x:150, y:1)
//    }
//}
