//
//  ContentView.swift
//  hello WatchKit Extension
//
//  Created by doge-to-the-moon on 2023-10-13.
//

import SwiftUI
import Foundation
import UserNotifications



var hapticTypes = [
    "Notification": WKHapticType.notification,
    "DirectionUp": WKHapticType.directionUp,
    "DirectionDown": WKHapticType.directionDown,
    "Success": WKHapticType.success,
    "Failure": WKHapticType.failure,
    "Retry": WKHapticType.retry,
    "Start": WKHapticType.start,
    "Stop": WKHapticType.stop,
    "Click": WKHapticType.click,
]

var reminders = [
    ("背单词", "Study vocabulary"),
    //    ("吃药", "Take medication"),
    //    ("健身", "Exercise"),
    //    ("遛狗", "Walk the dog"),
    //    ("学乐器", "Practice an instrument"),
    //    ("编码", "Code"),
    //    ("画画", "Paint"),
    //    ("学语言", "Learn a language"),
    //    ("清洁", "Clean"),
    //    ("野餐", "Have a picnic"),
    //    ("读信", "Check mail"),
    //    ("浏览网站", "Browse websites"),
    //    ("探索", "Explore"),
    //    ("休息", "Relax"),
    //    ("学习", "Study"),
    //    ("阅读", "Read"),
    //    ("写作", "Write"),
    //    ("瑜伽", "Yoga"),
    //    ("冥想", "Meditate"),
    ("购物", "Shop"),
    ("烹饪", "Cook"),
    ("洗衣", "Laundry"),
    ("打电话", "Call"),
    ("工作", "Work")
]


struct ContentView: View {
    @State private var opacity = 0.0
    @State private var txt = ""
    @State private var confirm = false
    
    var body: some View {
        let notify = hapticTypes["Notification"]
        let directionUp = hapticTypes["DirectionUp"]
        let directionDown = hapticTypes["DirectionDown"]
        let success = hapticTypes["Success"]
        let failure = hapticTypes["Failure"]
        let retry = hapticTypes["Retry"]
        let start = hapticTypes["Start"]
        let stop = hapticTypes["Stop"]
        let click = hapticTypes["Click"]
        
        var arrHabits = Array(repeating: -1, count: reminders.count)
    

        NavigationView{
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(reminders.indices,id:\.self) {proxy in
                        let english = reminders[proxy].1
                        let chinese = reminders[proxy].0
                        
                        Button(action: {
                            // 按钮被点击时执行的操作
                            print("Button \(proxy) tapped")
                            WKInterfaceDevice.current().play(click!)
                            if arrHabits[proxy] == 0 {
                                arrHabits[proxy] = 1
                            }
                            else{
                                arrHabits[proxy] = 0
                            }
                        }, label: {
                            Text(chinese)
                        })
                    }
                }
                HStack(content: {
                    Button(action: {
                        // 按钮被点击时执行的操作
                        print("Button CANCEL tapped")
                        WKInterfaceDevice.current().play(failure!)
                    }, label: {
                        Text("Cancel")
                        // jump to the first element of the list
                    })
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .buttonStyle(BorderedButtonStyle()).tint(Color.red)
                    
                    
                    NavigationLink(
                        "", destination: Text("HOLA!"),
                        isActive: $confirm
                    ).onTapGesture(perform: {
                        
                    })
                    .frame(maxWidth: 1,maxHeight: 1)
                    .hidden()
                    sss
                    
                    Button(action: {
                        // 按钮被点击时执行的操作
                        print("Button YES tapped")
                        print(arrHabits)
                        WKInterfaceDevice.current().play(success!)
                        confirm.toggle()
                    }, label: {
                        Text("YES!🐮")
                    })
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .buttonStyle(BorderedButtonStyle()).tint(Color.green)
                    
                    
                }
                )
                
            }
        }
        
        
        
        
    }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



