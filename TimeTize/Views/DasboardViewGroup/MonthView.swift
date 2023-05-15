//
//  MonthView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 15/05/23.
//

import SwiftUI

struct MonthView: View {
    @ObservedObject var myData = sharedData
    @State var selectedDate: Date = Date()  // Selection date variable for the datepicker
    @State var shouldShowNewTaskView = false    // Variable for the modal view selection
    @State var thisTask: PlannedTask?  // Placeholder task for the task information
    @Environment(\.colorScheme) var colorScheme // Variable for the dark mode selection
    
    var body: some View {
        // Calendar
        DatePicker("Label", selection: $selectedDate, displayedComponents: [.date])
            .datePickerStyle(.graphical) //It makes the picker look like a calendar
            .background() //It sets a null shape in order to change its color according to system mode
            .foregroundColor(Color.white) //It will then change when it's dark mode
            .cornerRadius(15)
            .padding(.top, 10)
            .padding(.horizontal)
        // Summary of current day's tasks
        Text("Summary")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .padding(.horizontal)
        // START OF SCROLLVIEW that allows only tasks to scroll
        ScrollView {
            // START OF FOREACH for all the cards
            ForEach(myData.tasks) { task in
                // Card showed only if the task relies on the actual day
                // The strange modifier that starts with ISO makes the range only about day, month and year, not including hour and minutes, that would have generated a bug
                let range = task.taskStart.ISO8601Format(.iso8601.year().month().day())...task.taskEnd.ISO8601Format(.iso8601.year().month().day())
                if(range.contains(selectedDate.ISO8601Format(.iso8601.year().month().day()))){
                    // Card for the task information
                    Button {
                        self.thisTask = task
                    } label: {
                        CardView(name: task.taskName, start: Data().toString(format: "YY/MM/dd hh:mm a", dateSource: task.taskStart), end: Data().toString(format: "YY/MM/dd hh:mm a", dateSource: task.taskEnd), index: task.tagIndex, priority: task.priority)
                            .foregroundColor(colorScheme == .light ? .white: .black)
                    }
                }
            }
            // END OF FOREACH
        }
        // END OF SCROLLVIEW
        .navigationTitle("Dashboard")
        .padding(.horizontal, 15)
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

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView()
    }
}
