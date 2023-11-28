//
//  CustomizeButton.swift
//  hello WatchKit Extension
//
//  Created by doge-to-the-moon on 2023-11-26.
//

import Foundation
import SwiftUI

struct CustomizeButton: View {
    let title: String
    let hapticName: WKHapticType
    var color: Color?
    var cornerRadius: CGFloat = 22
    
    var action: () -> Void
        
    var body: some View{
        Button(action:{
            WKInterfaceDevice.current().play(hapticName)
            action()
            
        }){
            Text(title)
            
            
        }.background(color ?? .clear)
        
        
    }
    
}
