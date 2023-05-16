//
//  FreeTimeView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI

struct FreeTimeView: View {
    
    @State var name = ""
    @ObservedObject var myData = sharedData
    
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
                // START OF FOREACH to show all the set free time
                ForEach(myData.freeTimes){ ft in
                    NewFreeTimeView(freeTime: ft, oldFreeTime: ft)
                }
                .onDelete { ft in
                    myData.freeTimes.remove(atOffsets: ft)
                }
                // END OF FOREACH
                // Button to add new free time
                Button("Add new free time") {
                    myData.freeTimes.append(FreeTime(name: "", start: Date(), end: Date()))
                    print(myData.freeTimes)
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
