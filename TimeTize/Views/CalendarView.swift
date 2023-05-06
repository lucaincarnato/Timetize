//
//  ContentView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 21/04/23.
//

import SwiftUI
import Foundation

struct CalendarView: View {
    
    func toString(format: String, dateSource: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: dateSource)
    }
    
    let hours: [String] = ["12 AM","1 AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM", "7 AM", "8 AM", "9 AM", "10 AM", "11 AM", "12 PM", "1 PM", "2 PM", "3 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM", "10 PM", "11 PM"]
    
    @ObservedObject var myData = sharedData
    @State var selectedDate: Date = Date()
    @State private var period = 0
    @State var shouldShowNewTaskView = false
    @State var shouldShowSettingsView = false
    @State var task: Task?
    @Environment(\.colorScheme) var colorScheme
    
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
                            // START OF VSTACK for all the cards
                            ForEach(myData.tasks) { task in
                                if(toString(format: "HH/MM/dd", dateSource: selectedDate) == toString(format: "HH/MM/dd", dateSource: task.taskStart)){
                                    Button {
                                        self.task = task
                                    } label: {
                                        CardView(name: task.taskName, hour: task.taskRange, tag: task.tagName, priority: 3)
                                            .foregroundColor(colorScheme == .light ? .white: .black)
                                    }
                                    // END OF ZSTACK
                                }
                            }
                            // END OF VSTACK
                        }
                        .navigationTitle("Tasks")
                        .padding(.horizontal, 15)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button (action: {shouldShowNewTaskView = true}) {
                                    Image(systemName: "plus")
                                }
                                
                            }
                        }
                        .fullScreenCover(isPresented: $shouldShowNewTaskView) {
                            NewTaskView()
                        }
                        // END OF SCROLLVIEW
                        // Case for the week view
                    case 1:
                        ScrollView {
                            ForEach (myData.tasks){ task in
                                Button {
                                    self.task = task
                                } label: {
                                    CardView(name: task.taskName, hour: task.taskRange, tag: task.tagName, priority: 3)
                                        .foregroundColor(colorScheme == .light ? .white: .black)
                                }
                            }
                        }
                        .navigationTitle("Tasks")
                        .padding(.vertical,20)
                        .padding(.horizontal)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button (action: {shouldShowNewTaskView = true}) {
                                    Image(systemName: "plus")
                                }
                                
                            }
                        }
                        .fullScreenCover(isPresented: $shouldShowNewTaskView) {
                            NewTaskView()
                        }
                        // Case for the day view
                    case 2:
                        ScrollView {
                            HStack {
                                VStack(spacing: 28) {
                                    ForEach(hours, id: \.self) { hour in
                                        HStack {
                                            Text(hour)
                                                .font(Font.custom("Avenir", size: 9))
                                                .frame(width: 28, height: 20, alignment: .center)
                                            VStack {
                                                Divider()
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.vertical)
                        }
                        .padding(.bottom, 90)
                        .padding(.horizontal, 16)
                        .ignoresSafeArea()
                        .navigationTitle("Tasks")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button (action: {shouldShowNewTaskView = true}) {
                                    Image(systemName: "plus")
                                }
                                
                            }
                        }
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
            .sheet(item: $task) { task in
                TaskInfoView(task: task)
            }
            // END OF ZSTACK
        }
        // END OF NAVIGATION STACK
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
