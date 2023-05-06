//
//  Data.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 21/04/23.
//

import SwiftUI

class SharedData: ObservableObject {
    
    // Random set of tasks, not the final one
    @Published var tasks = [
        Task(taskName: "Presentation Review", taskStart: Date.now, taskEnd: Date.now, taskRange: "8:00-12:00", repStart: Date.now, repEnd: Date.now, notification: false, tagName: "Personal", searched: false)
    ]
    
    @Published var newTasks: [Task] = [
        Task(taskName: "", taskStart: Date(), taskEnd: Date(), taskRange: "", repStart: Date(), repEnd: Date(), notification: false, tagName: "", searched: false)
]
    
    @Published var tags = [
        Tag(tagName: "Personal", colro: .green, taskIndex: 0),
        Tag(tagName: "Work", colro: .blue, taskIndex: 1),
        Tag(tagName: "Family", colro: .pink, taskIndex: 2)
    ]
    
}

var sharedData = SharedData()
