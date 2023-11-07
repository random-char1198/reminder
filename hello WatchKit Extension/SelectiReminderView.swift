//
//  SelectiReminderView.swift
//  hello WatchKit Extension
//
//  Created by doge-to-the-moon on 2023-10-27.
//

import SwiftUI

struct SelectiReminderView: View {
    var habits:HabitsDataBinding
    
    var body: some View {
        Text(habits.display())
//        Text(habits.map{String($0)}.joined(separator: ", "))
    }
}

//#Preview {
//    SelectiReminderView(habits: [1,2,3])
//}
