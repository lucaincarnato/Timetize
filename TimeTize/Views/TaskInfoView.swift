//
//  TaskInfoView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 03/05/23.
//

import SwiftUI

struct TaskInfoView: View {
    
    @State var task: PlannedTask   // Placeholder task
    
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
                    NavigationLink(destination: PriorityView(indexOne: 0.0, indexTwo: 0.0, indexThree: 0.0)){
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
                        NavigationLink(destination: NotificationImageView()){
                            Text("Image notification")
                        }
                    }
                    Picker(selection: $task.tagIndex, label: Text("Tag")) {
                        ForEach(0..<myData.tags.count, id: \.self) { i in
                            Text(myData.tags[i].tagName).tag(i)
                        }
                    }
                }
                // END OF SECTION
                // Button to delete the task
                Button("Delete task") {
                    dismiss()
                    myData.tasks.remove(at: myData.tasks.firstIndex(of: task)!)
                }
                .padding(.leading, 125.0)
                .foregroundColor(.red)
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
        TaskInfoView(task: PlannedTask(taskName: "", taskStart: Date(), taskEnd: Date(),  repStart: Date(), repEnd: Date(), notification: false, tagIndex: 0, searched: false))
    }
}
