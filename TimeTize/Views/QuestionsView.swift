//
//  QuestionsView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 28/04/23.
//

import SwiftUI

struct QuestionsView: View {
    
    // Information of a task
    @Binding var name: String
    @Binding var shouldFreeze: Bool
    @Binding var shouldAllowNotifications: Bool
    @Binding var start: Date
    @Binding var end: Date
    @Binding var index: Int
    @Binding var tags: [Tag]
    
    @ObservedObject var myData = sharedData
        
    
    var body: some View {
        // START OF SECTION for the new task form
        Section(header: Text("info and properties"), footer: Text("Slide any section to delete"))  {
            TextField("Task's name", text: $name)
            // It is shown only if the task is freezed
            if(shouldFreeze){
                DatePicker(selection: $start, label: { Text("Start") })
                DatePicker(selection: $end, label: { Text("End") })
            } else {
                NavigationLink(destination: DurationView()){
                    Text("Duration")
                }
                NavigationLink(destination: PriorityView(indexOne: 0.0, indexTwo: 0.0, indexThree: 0.0)){
                    Text("Priority")
                }
            }
            Toggle(isOn: $shouldFreeze, label: {
                Text("Freeze task")
            })
            NavigationLink(destination: RepetitionView()){
                Text("Repetition")
            }
            Toggle(isOn: $shouldAllowNotifications, label: {
                Text("Notification")
            })
            // It is shown only if the task has notification
            if(shouldAllowNotifications){
                NavigationLink(destination: WallpaperAlertView()){
                    Text("Image notification")
                }
            }
            Picker(selection: $index, label: Text("Tag")) {
                ForEach(tags) { tag in
                    Text(tag.tagName).tag(tag.taskIndex)
                }
            }
        }
        // END OF SECTION
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView(name: .constant(""), shouldFreeze: .constant(false), shouldAllowNotifications: .constant(false), start: .constant(Date()), end: .constant(Date()), index: .constant(0),  tags: .constant([Tag(tagName: "Work", colro: .blue, taskIndex: 0)]))
    }
}
