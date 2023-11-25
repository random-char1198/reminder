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
        ScrollView(content: {
            Text(habits.display())
            VStack(content: {
                ForEach(habits.arrHabits.indices, id: \.self){ index in
                    if (habits.arrHabits[index] == 1){
                        Button("\(habits.retrieveItem(id: index))", action: {})
                    }
//                    Text("\(habits.arrHabits[index])")
                }

            })
        })

//        Text(habits.map{String($0)}.joined(separator: ", "))
    }
}

//#Preview {
//    SelectiReminderView(habits: [1,2,3])
//}
