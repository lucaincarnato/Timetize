//
//  RepetitionView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI

struct RepetitionView: View {
    
    @State var repetitionPeriod = 0
    @State var repetitionCustomMinutes = 0
    @State var repetitionCustomFrequency = 0
    
    var body: some View {
        NavigationStack {
            Form{
                Section("Chose repetition period"){
                    DatePicker(selection: .constant(Date()), displayedComponents: .date, label: { Text("Start") })
                    DatePicker(selection: .constant(Date()), displayedComponents: .date, label: { Text("End") })
                }
                Section ("Chose interval repetition"){
                    Picker(selection: $repetitionPeriod, label: Text("Repeat")) {
                        Text("Every day").tag(0)
                        Text("Every week").tag(1)
                        Text("Every 2 weeks").tag(2)
                        Text("Every month").tag(3)
                        Text("Every year").tag(4)
                        Text("Custom").tag(5)
                    }
                    if(repetitionPeriod == 5){
                        Picker(selection: $repetitionCustomFrequency, label: Text("Frequency")){
                            Text("Daily").tag(0)
                            Text("Weekly").tag(1)
                            Text("Monthly").tag(2)
                            Text("Yearly").tag(3)
                        }
                        Picker(selection: $repetitionCustomMinutes, label: Text("Custom")) {
                            ForEach(1..<366, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
            }
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Repetition")
        }//MARK: END NAV.STACK
    }
}

struct RepetitionView_Previews: PreviewProvider {
    static var previews: some View {
        RepetitionView()
    }
}
