//
//  WeekView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 15/05/23.
//

import SwiftUI

struct WeekView: View {
    @ObservedObject var myData = sharedData
    @State var shouldShowNewTaskView = false    // Variable for the modal view selection
    @State var thisTask: PlannedTask?  // Placeholder task for the task information
    @Environment(\.colorScheme) var colorScheme // Variable for the dark mode selection
    
    var body: some View {
        // START OF SCROLLVIEW
        ScrollView {
            // START OF FOREACH for the cards
            ForEach (myData.tasks){ task in
                // Card for the task information
                Button {
                    self.thisTask = task
                } label: {
                    CardView(name: task.taskName, start: Data().toString(format: "YY/MM/dd hh:mm a", dateSource: task.taskStart), end: Data().toString(format: "YY/MM/dd hh:mm a", dateSource: task.taskEnd), index: task.tagIndex, priority: task.priority)
                        .foregroundColor(colorScheme == .light ? .white: .black)
                }
            }
            // END OF FOREACH
        }
        // END OF SCROLLVIEW
        .navigationTitle("Dashboard")
        .padding(.vertical,20)
        .padding(.horizontal)
        // Button to add new tasks
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    shouldShowNewTaskView = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
        // Modal view for the new task
        .fullScreenCover(isPresented: $shouldShowNewTaskView) {
            NewTaskView()
        }
        .sheet(item: $thisTask) { task in
            TaskInfoView(task: task)
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
