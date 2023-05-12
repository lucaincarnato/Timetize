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
        PlannedTask(taskName: "Presentation Review", taskStart: Date.now.addingTimeInterval(-500), taskEnd: Date.now.addingTimeInterval(87400), taskRange: "8:00-12:00", repStart: Date.now, repEnd: Date.now, notification: false, tagIndex: 0, searched: false)
    ]
    
    // Array for the new task, the one to be added
    @Published var newTasks: [PlannedTask] = [
        PlannedTask(taskName: "", taskStart: Date(), taskEnd: Date(), taskRange: "", repStart: Date(), repEnd: Date(), notification: false, tagIndex: 0, searched: false)
    ]
    
    // Array for the tags
    @Published var tags = [
        Tag(tagName: "Personal"),
        Tag(tagName: "Work"),
        Tag(tagName: "Family")
    ]
    
    // Array for the free times
    @Published var freeTimes = [
        FreeTime(name: "Dinner", start: Date.now, end: Date.now.addingTimeInterval(3600))
    ]
    
    // Variables that will store the sleep and wake up periods
//    @Published var wakeUp
//    @Published var goToSleep
}

var sharedData = SharedData()
