//
//  SettingsView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI
import PhotosUI

struct SettingsView: View {
    @State var name: String = ""
    @State private var Wallpaper = false
    @State private var shouldAllowNotifications = false
    @State var selectedItem: PhotosPickerItem?
    @State var index = 0
    
    @State var repetitionPeriod = 0
    @State var repetitionCustomMinutes = 0
    @State var repetitionCustomFrequency = 0
    
    @ObservedObject var myData = sharedData
    @State var shouldHideNewTaskView = false
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Calendar settings")){
                    NavigationLink(destination: FreeTimeView() ){
                        Text("FreeTime")
                    }
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
                    NavigationLink(destination: TagsView()){
                        Text("Tags")
                    }
                    NavigationLink(destination: HelpView()){
                        Text("Help")
                    }
                }
            }//MARK: END FORM
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Settings")
        }//MARK: END NAV.STACK
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
