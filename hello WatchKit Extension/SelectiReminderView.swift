//
//  SelectiReminderView.swift
//  hello WatchKit Extension
//
//  Created by doge-to-the-moon on 2023-10-27.
//

import SwiftUI

struct SelectiReminderView: View {
    
    enum ButtonState {
        case normal, green, red
    }
    
    @State private var buttonStates: [Int: ButtonState] = [:]
    
    var habits:HabitsDataBinding
    
    var body: some View {
        ScrollView {
            Text(habits.display())
            VStack {
                ForEach(habits.arrHabits.indices, id: \.self) { index in
                    if habits.arrHabits[index] == 1 {
//                        Button("\(habits.retrieveItem(id: index))") {
//                            toggleButtonState(index: index)
//                        }
                        let name = habits.retrieveItem(id: index)
                        CustomizeButton(title: name, hapticName: .success, color: Color.brown, action: {})
                        .background(backgroundColor(for: index)) // change background colour based on each button.
                        .cornerRadius(24) // making sure background alaso has corner radius
                    }
                }
            }
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
                buttonStates[index] = .normal
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
}

//#Preview {
//    SelectiReminderView(habits: [1,2,3])
//}
