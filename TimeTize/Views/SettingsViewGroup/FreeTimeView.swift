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
        NavigationStack {
            Form{
                Section("Sleep time"){
                    DatePicker(selection: .constant(Date()), displayedComponents: .hourAndMinute, label: { Text("Day starts at") })
                    DatePicker(selection: .constant(Date()), displayedComponents: .hourAndMinute, label: { Text("Day ends at") })
                }
                Section("Other free times") {
                    TextField("Free time's name", text: $name)
                    DatePicker(selection: .constant(Date()), displayedComponents: .hourAndMinute, label: { Text("Start") })
                    DatePicker(selection: .constant(Date()), displayedComponents: .hourAndMinute, label: { Text("End") })
                    DatePicker(selection: .constant(Date()), displayedComponents: .date, label: { Text("From") })
                    DatePicker(selection: .constant(Date()), displayedComponents: .date, label: { Text("To") })
                }
                Button("Add new free time") {
                    print("ciao")
                }.padding(.leading, 100.0)
            }
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Free time")
        }//MARK: END NAV.STACK
    }
}

struct FreeTimeView_Previews: PreviewProvider {
    static var previews: some View {
        FreeTimeView()
    }
}
