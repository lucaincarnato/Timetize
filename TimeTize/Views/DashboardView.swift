//
//  ContentView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 21/04/23.
//



import SwiftUI
import Foundation
import UserNotifications

struct DashboardView: View {
    
    
    // Function to format a Date to string
    func toString(format: String, dateSource: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: dateSource)
    }
    
    // Constant variable for all the hours slots
    let hours: [String] = ["12 AM","1 AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM", "7 AM", "8 AM", "9 AM", "10 AM", "11 AM", "12 PM", "1 PM", "2 PM", "3 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM", "10 PM", "11 PM"]
    
    @ObservedObject var myData = sharedData
    @State var selectedDate: Date = Date()  // Selection date variable for the datepicker
    @State private var period = 0   // Variable for the period selection of the picker
    @State var shouldShowNewTaskView = false    // Variable for the modal view selection
    @State var task: PlannedTask?  // Placeholder task for the task information
    @Environment(\.colorScheme) var colorScheme // Variable for the dark mode selection
    
    var body: some View {
        // START OF NAVIGATION STACK
        NavigationStack {
            // START OF ZSTACK used to allow the background color to fill the sceen according to system mode
            ZStack {
                // Background color that fills up the entire screen
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea()
                // START OF VSTACK where are located all the elements
                VStack {
                    // Segmented picker that allow different views
                    Picker("Select period", selection: $period) {
                        Text("Month").tag(0)
                        Text("Week").tag(1)
                        Text("Day").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .padding(.top)
                    .padding(.horizontal)
                    // START OF SWITCH that allows switching between views
                    switch(period){
                        // Case for the month view
                    case 0:
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
                                        self.task = task
                                    } label: {
                                        CardView(name: task.taskName, start: toString(format: "YY/MM/dd hh:mm a", dateSource: task.taskStart), end: toString(format: "YY/MM/dd hh:mm a", dateSource: task.taskEnd), index: task.tagIndex, priority: 3)
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
                        // Case for the week view
                    case 1:
                        // START OF SCROLLVIEW
                        ScrollView {
                            // START OF FOREACH for the cards
                            ForEach (myData.tasks){ task in
                                // Card for the task information
                                Button {
                                    self.task = task
                                } label: {
                                    CardView(name: task.taskName, start: toString(format: "YY/MM/dd hh:mm a", dateSource: task.taskStart), end: toString(format: "YY/MM/dd hh:mm a", dateSource: task.taskEnd), index: task.tagIndex, priority: 3)
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
                        // Case for the day view
                    case 2:
                        // START OF SCROLLVIEW
                        ScrollView {
                            // START OF HSTACK for the hourly dividers
                            HStack {
                                // START OF VSTACK for the hour
                                VStack(spacing: 28) {
                                    ForEach(hours, id: \.self) { hour in
                                        // START OF HSTACK
                                        HStack {
                                            // Hour text
                                            Text(hour)
                                                .font(Font.custom("Avenir", size: 9))
                                                .frame(width: 28, height: 20, alignment: .center)
                                            // Line
                                            VStack {
                                                Divider()
                                            }
                                        }
                                        // END OF HSTACK
                                    }
                                }
                                // END OF VSTACK
                                Spacer() // To give some space between hours
                            }
                            // END OF HSTACK
                            .padding(.vertical)
                        }
                        // END OF SCROLLVIEW
                        .padding(.bottom, 90)
                        .padding(.horizontal, 16)
                        .ignoresSafeArea()
                        .navigationTitle("Dashboard")
                        // Button to add new task
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    shouldShowNewTaskView = true
                                } label: {
                                    Image(systemName: "plus")
                                }
                                
                            }
                        }
                        // Modal view for new task
                        .fullScreenCover(isPresented: $shouldShowNewTaskView) {
                            NewTaskView()
                        }
                        // The default case SHOULD not be available to the user
                    default:
                        Text("Something went wrong")
                    }
                    // END OF SWITCH
                }
                // END OF VSTACK
            }
            // END OF ZSTACK
            // It shows the Task informations when the card is clicked
            .sheet(item: $task) { task in
                TaskInfoView(task: task)
            }
        }
        // END OF NAVIGATION STACK
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
