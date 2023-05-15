//
//  Data.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 21/04/23.
//

import SwiftUI
import UserNotifications

class Data: ObservableObject {
    // Function to get the permission to send notifications once hit plus
    func allowNotifications(title: String, subtitle: String) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.notify(title: title, subtitle: subtitle)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // NEXT: MAKE THE PUSH NOTIFICATION WITH THE FOLLOWING CODE
    func notify(title: String, subtitle: String){
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        
        if let imageURL = Bundle.main.url(forResource: "cat", withExtension: "png") {
            let attachment = try? UNNotificationAttachment(identifier: "image", url: imageURL, options: nil)
            
            content.attachments = [attachment!]
        }
        
        let setReminder = Date().addingTimeInterval(30)
        let comp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: setReminder)
        
        // show this notification five seconds from now
        let trigger = UNCalendarNotificationTrigger(dateMatching: comp, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        center.add(request)
    }
    
    // Function to format a Date to string
    func toString(format: String, dateSource: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: dateSource)
    }
    
    // Function to assign each priority value a color
    func toColor(priority: Int)->Color{
        switch(priority){
        case 0:
            return Color.blue
        case 1:
            return Color.cyan
        case 2:
            return Color.teal
        case 3:
            return Color.green
        case 4:
            return Color.yellow
        case 5:
            return Color.orange
        case 6:
            return Color.red
        default:
            return Color.gray
        }
    }
    
    // Array with the planned tasks
    @Published var tasks = [
        PlannedTask(taskName: "Presentation Review", taskStart: Date.now.addingTimeInterval(-500), taskEnd: Date.now.addingTimeInterval(87400), repStart: Date.now, repEnd: Date.now, notification: false, tagIndex: 0, searched: false, priority: 6)
    ]
    
    // Array for the new task, the one to be added
    @Published var newTasks: [PlannedTask] = [
        PlannedTask(taskName: "", taskStart: Date(), taskEnd: Date(), repStart: Date(), repEnd: Date(), notification: false, tagIndex: 0, searched: false, priority: 0)
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

var sharedData = Data()
