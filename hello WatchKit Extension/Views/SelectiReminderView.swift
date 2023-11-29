//
//  SelectiReminderView.swift
//  hello WatchKit Extension
//
//  Created by doge-to-the-moon on 2023-10-27.
//

import SwiftUI

struct SelectiReminderView: View {
    @State private var dateStr: String = ""
    enum ButtonState {
        case normal, green, red
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
            VStack {
                ForEach(habits.arrHabits.indices, id: \.self) { index in
                    if habits.arrHabits[index] == 1 {
                        //                        Button("\(habits.retrieveItem(id: index))") {
                        //                            toggleButtonState(index: index)
                        //                        }
                        let name = habits.retrieveItem(id: index)
                        CustomizeButton(title: name, hapticName: .success, color: nil, action: {
                            toggleButtonState(index: index)
                        })
                        .background(backgroundColor(for: index)) // change background colour based on each button.
                        .cornerRadius(24) // making sure background alaso has corner radius
                    }
                }
            }
            HStack(content: {
                Button("", systemImage: "arrowshape.left.fill", action: {
                    formatDate(dateSelection: false)
                    //switching date
                })
                Button("",systemImage: "arrowshape.right.fill",action: {
                    formatDate(dateSelection: true)
                    
                })
            })
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
