//
//  SettingsView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI
import PhotosUI

struct SettingsView: View {
    
    @State var repetitionPeriod = 0 // Variable to show the moment of notification
    @State var repetitionCustomMinutes = 0  // Variable to select the range of custom repetition
    @State var repetitionCustomFrequency = 0    // Variable to select the value of custom repetition
    
    @ObservedObject var myData = sharedData
    
    var body: some View {
        // START OF NAVIGATION STACK
        NavigationStack {
            // START OF FORM
            Form {
                // START OF SECTION
                Section(header: Text("Calendar settings")){
                    // Push navigation to the Free Time View
                    NavigationLink(destination: FreeTimeView() ){
                        Text("FreeTime")
                    }
                    // Picker for the show notification option
                    Picker(selection: $repetitionPeriod, label: Text("Show notification")) {
                        Text("5 minutes before").tag(0)
                        Text("15 minutes before").tag(1)
                        Text("30 minutes before").tag(2)
                        Text("1 hour before").tag(3)
                        Text("2 hours before").tag(4)
                        Text("1 day before").tag(5)
                        Text("2 days before").tag(6)
                        Text("1 week before").tag(7)
                        Text("2 weeks before").tag(8)
                        Text("Custom").tag(9)
                    }
                    // If statement to select the custom setting for the show notification option
                    if(repetitionPeriod == 9){
                        Picker(selection: $repetitionCustomFrequency, label: Text("Timeframe")){
                            Text("Minutes").tag(0)
                            Text("Hours").tag(0)
                            Text("Days").tag(0)
                            Text("Weeks").tag(1)
                            Text("Months").tag(2)
                        }
                        Picker(selection: $repetitionCustomMinutes, label: Text("Custom")) {
                            ForEach(1..<366, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    // Push navigation for the Tag View
                    NavigationLink(destination: TagsView()){
                        Text("Tags")
                    }
                    // Push navigation for the Help View
                    NavigationLink(destination: HelpView()){
                        Text("Help")
                    }
                }
                // END OF SECTION
            }
            // END OF FORM
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Settings")
        }
        // END OF NAVIGATIONSTACK
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
