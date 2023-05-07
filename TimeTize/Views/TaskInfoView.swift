//
//  TaskInfoView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 03/05/23.
//

import SwiftUI

struct TaskInfoView: View {
    
    @State var task: Task   // Placeholder task
    
    @ObservedObject var myData = sharedData
    @Environment (\.dismiss) var dismiss
    
    // Function to format Date to String
    func toString(format: String, dateSource: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: dateSource)
    }
    
    var body: some View {
        // START OF NAVIGATIONSTACK
        NavigationStack {
            // START OF FORM
            Form {
                // START OF SECTION for the information of the task
                Section {
                    TextField("Task's name", text: $task.taskName)
                    DatePicker(selection: $task.taskStart, label: { Text("Start") })
                    DatePicker(selection: $task.taskEnd, label: { Text("End") })
                    NavigationLink(destination: PriorityView()){
                        Text("Priority")
                    }
                    NavigationLink(destination: RepetitionView()){
                        Text("Repetition")
                    }
                    Toggle(isOn: $task.notification, label: {
                        Text("Notification")
                    })
                    // Shown only if the notification is allowed
                    if(task.notification){
                        NavigationLink(destination: WallpaperAlertView()){
                            Text("Image notification")
                        }
                    }
                    Picker(selection: $task.tagName, label: Text("Tag")) {
                        ForEach(myData.tags) { tag in
                            Text(tag.tagName).tag(tag.taskIndex)
                        }
                    }
                }
                // END OF SECTION
            }
            // END OF FORM
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Task informations")
            .toolbar {
                ToolbarItem (placement: .cancellationAction){
                    Button ("Cancel"){
                        dismiss()
                    }
                }
            }
        }
        // END OF NAVIGATIONSTACK
    }
}

struct TaskInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TaskInfoView(task: Task(taskName: "", taskStart: Date(), taskEnd: Date(), taskRange: "", repStart: Date(), repEnd: Date(), notification: false, tagName: "", searched: false))
    }
}
