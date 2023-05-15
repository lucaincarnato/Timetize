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
    @ObservedObject var myData = sharedData
    @State private var period = 0   // Variable for the period selection of the picker
    @State var task: PlannedTask?  // Placeholder task for the task information
    
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
                        MonthView()
                        // Case for the week view
                    case 1:
                        WeekView()
                        // Case for the day view
                    case 2:
                        DayView()
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
        }
        // END OF NAVIGATION STACK
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
