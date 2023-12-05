//
//  SelectiReminderView.swift
//  hello WatchKit Extension
//
//  Created by doge-to-the-moon on 2023-10-27.
//

import SwiftUI

struct SelectiReminderView: View {
    @State private var dateStr: String = ""
    @State private var resetStatus: Bool = false
    enum ButtonState {
        case normal, green, red
        
        var stringValue: String {
            switch self {
            case .normal:
                return "normal"
            case .green:
                return "green"
            case .red:
                return "red"
            }
        }
        
        
        init?(stringValue: String) {
            switch stringValue {
            case "normal":
                self = .normal
            case "green":
                self = .green
            case "red":
                self = .red
            default:
                return nil
            }
        }
    }
    
    
    
    @State private var buttonStates: [Int: ButtonState] = [:]
    @State private var currentDate:Date = Date()
    
    var habits:HabitsDataBinding
    
    var body: some View {
        ScrollView {
            //            Text(habits.display())
            Text(dateStr)
                .onAppear(perform: {
                    
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    formatter.timeStyle = .none
                    
                    self.dateStr = formatter.string(from: currentDate)
                    
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    print(habits.arrHabits[0])
                    print(buttonStates[0] ?? "hhhhhh")
                }
            Spacer()
            VStack {
                ForEach(habits.arrHabits.indices, id: \.self) { index in
                    if habits.arrHabits[index] == 1 {
                        //                        Button("\(habits.retrieveItem(id: index))") {
                        //                            toggleButtonState(index: index)
                        //                        }
                        let name = habits.retrieveItem(id: index)
                        CustomizeButton(title: name, hapticName: .success, color: nil, action: {
                            //                            print("ToggledState Index \(index)")
                            //                            print("Arrary \(habits.arrHabits)")
                            toggleButtonState(index: index)
                            
                        })
                        .background(backgroundColor(for: index)) // change background colour based on each button.
                        .cornerRadius(24) // making sure background alaso has corner radius
                    }
                }
            }
            HStack(content: {
                Button("", systemImage: "arrowshape.left.fill", action: {
                    storeData(dateString: self.dateStr, value: buttonStates)
                    formatDate(dateSelection: false)
                    
                    resetToNormal()
                    print("Left <--- Current Date \(self.dateStr)")
                    restoreDate(dateString: self.dateStr)
                    
                })
                Button("",systemImage: "arrowshape.right.fill",action: {
                    storeData(dateString: self.dateStr, value: buttonStates)
                    formatDate(dateSelection: true)
                    
                    print("Current Date \(self.dateStr) ---> Right")
                    
                    resetToNormal()
                    restoreDate(dateString: self.dateStr)
                    
                    
                })
            })
        }
    }
    func restoreDate(dateString: String)-> Void{
        
        if let restoredData = UserDefaults.standard.dictionary(forKey: dateString){
            var restoredState : [Int: ButtonState] = [:]
            
            for (keyString, valueString) in restoredData {
                if let key = Int(keyString), let value = valueString as? String, let state = ButtonState(stringValue: value) {
                    restoredState[key] = state
                }
            }
            buttonStates = restoredState

            
        }
        else{
            print("NOPE")
        }

        
    }
    func storeData(dateString: String, value:[Int: ButtonState]) -> Void {
        var stringValueStates: [String:String] = [:]
        for (k, v) in value{
            stringValueStates[String(k)] = v.stringValue
            //            print("Key: \(k), Value: \(v)")
        }
        if UserDefaults.standard.dictionary(forKey: dateString) == nil{
            //it is empty
            UserDefaults.standard.set(stringValueStates, forKey: dateString)
            print("Stored ", stringValueStates)
        }
        else{
            // it is not empty

        }
    }
    
    private func toggleButtonState(index: Int) {
        let currentState = buttonStates[index] ?? .normal
        switch currentState {
        case .normal:
            buttonStates[index] = .green
        case .green:
            buttonStates[index] = .red
        case .red:
            buttonStates[index] = .green
        }
        //        print("Final State is \(currentState)")
        //        print("Buttons State is \(buttonStates)")
        
        
    }
    private func resetToNormal() -> Void{
        // works fine
        for index in habits.arrHabits.indices{
            if habits.arrHabits[index] == 1{
                buttonStates[index] = .normal
                resetStatus = true
            }
        }
        
    }
    
    
    private func backgroundColor(for index: Int) -> Color {
        let state = buttonStates[index] ?? .normal
        switch state {
        case .normal:
            return Color(red: 34 / 255, green: 34 / 255, blue: 35 / 255)
        case .green:
            return .green
        case .red:
            return .red
        }
    }
    private func formatDate(dateSelection:Bool) -> Void{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        
        //        //store the date here
        //        storeData(dateString: self.dateStr, value: buttonStates)
        //        print("Stored Date is \(self.dateStr)")
        
        // true is tomorrow, false is yesterday
        if dateSelection{
            if let tomorrow = Calendar.current.date(byAdding:.day,value: 1, to: self.currentDate){
                self.currentDate = tomorrow
                
                self.dateStr = formatter.string(from: tomorrow)
                
            }
        }
        else{
            if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: self.currentDate){
                self.currentDate = yesterday
                
                self.dateStr = formatter.string(from: yesterday)
            }
        }
        
    }
}

//Button("Show Tomorrow") {
//    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
//    self.dateStr = formatDate(date: tomorrow)
//}

//#Preview {
//    SelectiReminderView(habits: [1,2,3])
//}
