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
        
        let reminders = ReminderJobs().jobs
        var arrHabits = Array(repeating: -1, count: reminders.count)

        let habits = HabitsDataBinding(arrHabits: arrHabits)
        

        NavigationView{
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(reminders.indices,id:\.self) {proxy in
                        let english = reminders[proxy].1
                        let chinese = reminders[proxy].0
                        
                        Button(action: {
                            // 按钮被点击时执行的操作
                            print("Button \(proxy) tapped")
                            print("This is habits: \(habits.display())")

                            WKInterfaceDevice.current().play(click!)
                            if habits.arrHabits[proxy] == -1 {
                                // Never
                                arrHabits[proxy] = 1
                                habits.setValue(num: proxy, setVal: 1)
                                
                            }
                            else{
                                arrHabits[proxy] = 0
                                habits.setValue(num: proxy, setVal: 0)
                            }
                        }, label: {
                            Text(chinese)
                        }).onTapGesture {
                            print("This is habits: \(habits.display())")
                        }
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
                        "", destination: SelectiReminderView(habits:habits ),
                        isActive: $confirm
                    )
                    .frame(maxWidth: 1,maxHeight: 1)
                    .hidden()
                    
                    
                    Button(action: {
                        // 按钮被点击时执行的操作
                        print("Button YES tapped")
                        print(habits.display())
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



