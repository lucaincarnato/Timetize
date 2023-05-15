//
//  DayView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 15/05/23.
//

import SwiftUI

struct DayView: View {
    @ObservedObject var myData = sharedData
    @State var shouldShowNewTaskView = false    // Variable for the modal view selection
    let hours: [String] = ["12 AM","1 AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM", "7 AM", "8 AM", "9 AM", "10 AM", "11 AM", "12 PM", "1 PM", "2 PM", "3 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM", "10 PM", "11 PM"]

    
    var body: some View {
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
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
    }
}
