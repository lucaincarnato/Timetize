//
//  Task.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 21/04/23.
//

import Foundation
import SwiftUI

// Component of each single task, not done yet
struct Task: Identifiable{
    var id = UUID()
    var taskName: String
    var taskStart: Date
    var taskEnd: Date
    var taskRange: String
    var repStart: Date
    var repEnd: Date
    var notification: Bool
    var tagName: String
    var searched: Bool
}

// Component of each tag
struct Tag: Identifiable{
    var id = UUID()
    var tagName: String
    var colro: Color
    var taskIndex: Int
}
