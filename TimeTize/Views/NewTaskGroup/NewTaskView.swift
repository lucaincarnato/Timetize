//
//  NewTaskView.swift
//  TimeTize
//
//  Created by Alessia Di Gioia  on 22/04/23.
//

import SwiftUI
import UserNotifications

struct NewTaskView: View {
    // Function to get the permission to send notifications once hit plus
    func allowNotifications(title: String, subtitle: String) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                notify(title: title, subtitle: subtitle)
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
    
    // Task information
    @State var name: String = ""
    @State private var shouldFreeze = false
    @State private var shouldAllowNotifications = false
    @State var start: Date = Date()
    @State var end: Date = Date().addingTimeInterval(3600)
    @State var range: String = ""
    @State var rStart: Date = Date()
    @State var rEnd: Date = Date()
    @State var index = 0
    @State var shouldPlan = false
    
    
    @ObservedObject var myData = sharedData
    @Environment (\.dismiss) var dismiss    // Variable to dismiss modal view
    
    // Function to format a Date to String
    func toString(format: String, dateSource: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: dateSource)
    }
    
    var body: some View {
        // START OF NAVIGATIONSTACK
        NavigationStack {
            // START OF FORM for all the new tasks
            Form {
                // START OF FOREACH
                ForEach(myData.newTasks){ task in
                    QuestionsView(name: $name, shouldFreeze: $shouldFreeze, shouldAllowNotifications: $shouldAllowNotifications, start: $start, end: $end, index: $index, tags: $myData.tags)
                }
                // END OF FOREACH
                // Sliding option to delete the new task form
                .onDelete { task in
                    myData.newTasks.remove(atOffsets: task)
                }
                // Button to add a new task form
                Button("Add new task") {
                    myData.newTasks.append(PlannedTask(taskName: "", taskStart: Date(), taskEnd: Date(), taskRange: "", repStart: Date(), repEnd: Date(), notification: false, tagIndex: 0, searched: false))
                }.padding(.leading, 100.0)
            }
            // END OF FORM
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Planning")
            .toolbar {
                // Button cancel to dismiss
                ToolbarItem (placement: .cancellationAction){
                    Button ("Cancel"){
                        dismiss()
                    }
                }
                // Done button to go to the automatic planning and add the freezed tasks
                ToolbarItem{
                    Button ("Done") {
                        myData.tasks.append(
                            PlannedTask(
                                taskName: name,
                                taskStart: start,
                                taskEnd: end,
                                taskRange: toString(format: "hh:mm", dateSource: start) + "-" + toString(format: "hh:mm", dateSource: end),
                                repStart: rStart,
                                repEnd: rEnd,
                                notification: false,
                                tagIndex: index,
                                searched: false
                            )
                        )
                        if(shouldAllowNotifications){
                            allowNotifications(title: name, subtitle: toString(format: "hh:mm", dateSource: start) + "-" + toString(format: "hh:mm", dateSource: end))
                        }
                        shouldPlan = true
                    }
                }
            }
            // Modal view for the automatic planning
            .sheet(isPresented: $shouldPlan){
                PlanView()
            }
        }
        // END OF NAVIGATION STACK
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
