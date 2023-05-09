//
//  Data.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 21/04/23.
//

import SwiftUI

class SharedData: ObservableObject {
    
    // Array with the planned tasks
    @Published var tasks = [
        Task(taskName: "Presentation Review", taskStart: Date.now.addingTimeInterval(-500), taskEnd: Date.now.addingTimeInterval(87400), taskRange: "8:00-12:00", repStart: Date.now, repEnd: Date.now, notification: false, tagIndex: 0, searched: false)
    ]
    
    // Array for the new task, the one to be added
    @Published var newTasks: [Task] = [
        Task(taskName: "", taskStart: Date(), taskEnd: Date(), taskRange: "", repStart: Date(), repEnd: Date(), notification: false, tagIndex: 0, searched: false)
    ]
    
    // Array for the tags
    @Published var tags = [
        Tag(tagName: "Personal"),
        Tag(tagName: "Work"),
        Tag(tagName: "Family")
    ]
}

var sharedData = SharedData()
