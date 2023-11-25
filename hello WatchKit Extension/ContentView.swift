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
    @State private var submitHabits = false

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
                        "", destination: SelectiReminderView(habits:habits)
//                            .navigationBarBackButtonHidden(true) -> delete this when ready
                        ,
                        isActive: $confirm
                    )
//                    .navigationBarBackButtonHidden(true)
                    .frame(maxWidth: 1,maxHeight: 1)
                    .hidden()
                    
                    
                    
                    Button(action: {
                        // 按钮被点击时执行的操作
                        print("Button YES tapped")
                        print(habits.display())
                        submitHabits = submitCheck(arr: habits.arrHabits)
                        
                        print(arrHabits)
                        WKInterfaceDevice.current().play(success!)
                        if(!submitCheck(arr: habits.arrHabits)){
                            confirm.toggle()
                        }
                        else{
                            print("BUZZZ")
                        }
                    }, label: {
                        Text("YES!🐮")
                    })
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .buttonStyle(BorderedButtonStyle()).tint(Color.green)
                    .alert("You did not any habit yet.", isPresented: $submitHabits, actions: {})
                    
                    
                }
                )
                
            }
        }
        
        
        
        
    }}

/// Checks if all elements in the array satisfy a specific condition.
///
/// This function takes an array of integers and checks if all elements in the array satisfy
/// the condition that each element is less than and equal 0.
///
/// - Parameters:
///   - arr: An array of integers to be checked.
///
/// - Returns: `true` if all elements in the array are less than 0; otherwise, it returns `false`.
///
/// - Note: If the input array is empty, the function will return `true` since there are no elements
/// to evaluate, and by default, the condition is satisfied.
///
/// Example:
/// ```
/// let positiveArray = [1, 2, 3]
/// let negativeArray = [-1, -2, -3]
/// let emptyArray: [Int] = []
///
/// let isAllNegative1 = submitCheck(arr: positiveArray) // false
/// let isAllNegative2 = submitCheck(arr: negativeArray) // true
/// let isAllNegative3 = submitCheck(arr: emptyArray) // true
/// ```
func submitCheck(arr: [Int]) -> Bool {
    return arr.allSatisfy { $0 <= 0 }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



