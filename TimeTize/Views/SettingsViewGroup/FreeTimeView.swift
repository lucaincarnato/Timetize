//
//  FreeTimeView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI

struct FreeTimeView: View {
    
    @State var name = ""
    
    var body: some View {
        // START OF NAVIGATIONSTACK
        NavigationStack {
            // START OF FORM
            Form{
                // START OF SECTION for the default free time, sleep time
                Section("Sleep time"){
                    DatePicker(selection: .constant(Date()), displayedComponents: .hourAndMinute, label: { Text("Day starts at") })
                    DatePicker(selection: .constant(Date()), displayedComponents: .hourAndMinute, label: { Text("Day ends at") })
                }
                // END OF SECTION
                // START OF SECTION for custom free time
                Section("Other free times") {
                    TextField("Free time's name", text: $name)
                    DatePicker(selection: .constant(Date()), displayedComponents: .hourAndMinute, label: { Text("Start") })
                    DatePicker(selection: .constant(Date()), displayedComponents: .hourAndMinute, label: { Text("End") })
                    DatePicker(selection: .constant(Date()), displayedComponents: .date, label: { Text("From") })
                    DatePicker(selection: .constant(Date()), displayedComponents: .date, label: { Text("To") })
                }
                // END OF SECTION
                // Button to add new free time
                Button("Add new free time") {
                    print("ciao")
                }.padding(.leading, 100.0)
            }
            // END OF FORM
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Free time")
        }
        // END OF NAVIGATION STACK
    }
}

struct FreeTimeView_Previews: PreviewProvider {
    static var previews: some View {
        FreeTimeView()
    }
}
