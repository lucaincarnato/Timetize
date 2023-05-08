//
//  NewTaskView.swift
//  TimeTize
//
//  Created by Alessia Di Gioia  on 22/04/23.
//

import SwiftUI

struct NewTaskView: View {
    
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
                    myData.newTasks.append(Task(taskName: "", taskStart: Date(), taskEnd: Date(), taskRange: "", repStart: Date(), repEnd: Date(), notification: false, tagName: "", searched: false))
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
                            Task(
                                taskName: name,
                                taskStart: start,
                                taskEnd: end,
                                taskRange: toString(format: "hh:mm", dateSource: start) + "-" + toString(format: "hh:mm", dateSource: end),
                                repStart: rStart,
                                repEnd: rEnd,
                                notification: false,
                                tagName: myData.tags[index].tagName,
                                searched: false
                            )
                        )
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
