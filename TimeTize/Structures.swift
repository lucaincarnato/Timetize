//
//  Task.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 21/04/23.
//

import Foundation
import SwiftUI

// Component of each single task, not done yet
// Identifiable is needed to iterate
// Equatable is needed to the remove function
struct PlannedTask: Identifiable, Equatable{
    var id = UUID()
    var taskName: String
    var taskStart: Date
    var taskEnd: Date
    var repStart: Date
    var repEnd: Date
    var notification: Bool
    var taskImage: Image?
    var tagIndex: Int
    var searched: Bool
    var priority: Int = 0
}

struct ToPlanTask: Identifiable, Equatable{
    var id = UUID()
    var taskName: String
    var Duration: Int
    var priority: Int
    var repStart: Date
    var repEnd: Date
    var notification: Bool
    var taskImage: Image?
    var tagIndex: Int
}

// Component of each tag
struct Tag: Identifiable{
    var id = UUID()
    var tagName: String
}

// Components for the free time
struct FreeTime: Identifiable{
    var id = UUID()
    var name: String
    var start: Date
    var end: Date
}
