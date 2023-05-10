//
//  NewFreeTimeView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 09/05/23.
//

import SwiftUI

struct NewFreeTimeView: View {
    
    @State var freeTime: FreeTime   // Placeholder free time
    @ObservedObject var myData = sharedData
    
    var body: some View {
        // START OF SECTION for custom free time
        Section(footer: Text("Slide any section to delete")) {
            TextField("Free time's name", text: $freeTime.name)
            DatePicker(selection: $freeTime.start, displayedComponents: .hourAndMinute, label: { Text("Start") })
            DatePicker(selection: $freeTime.end, displayedComponents: .hourAndMinute, label: { Text("End") })
        }
        .onSubmit {
            // Make changes in the array
            print("")
        }
        // END OF SECTION
    }
}

struct NewFreeTimeView_Previews: PreviewProvider {
    static var previews: some View {
        NewFreeTimeView(freeTime: FreeTime(name: "", start: Date(), end: Date()))
    }
}
