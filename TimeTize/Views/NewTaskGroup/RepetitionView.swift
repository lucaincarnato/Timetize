//
//  RepetitionView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI

struct RepetitionView: View {
    
    @State var repetitionPeriod = 0 // Placeholder picker selection
    @State var repetitionCustomMinutes = 0  // Placeholder interval selection
    @State var repetitionCustomFrequency = 0    // Placeholder value selection
    
    var body: some View {
        // START OF NAVIGATIONSTACK
        NavigationStack {
            // START OF FORM
            Form{
                // Section for the repetition period
                Section("Chose repetition period"){
                    DatePicker(selection: .constant(Date()), displayedComponents: .date, label: { Text("Start") })
                    DatePicker(selection: .constant(Date()), displayedComponents: .date, label: { Text("End") })
                }
                // START OF SECTION for the interval of the repetition
                Section ("Chose interval repetition"){
                    Picker(selection: $repetitionPeriod, label: Text("Repeat")) {
                        Text("Every day").tag(0)
                        Text("Every week").tag(1)
                        Text("Every 2 weeks").tag(2)
                        Text("Every month").tag(3)
                        Text("Every year").tag(4)
                        Text("Custom").tag(5)
                    }
                    // Allow of custom interval
                    if(repetitionPeriod == 5){
                        // Picker for the frequency
                        Picker(selection: $repetitionCustomFrequency, label: Text("Frequency")){
                            Text("Daily").tag(0)
                            Text("Weekly").tag(1)
                            Text("Monthly").tag(2)
                            Text("Yearly").tag(3)
                        }
                        // Picker for the value
                        Picker(selection: $repetitionCustomMinutes, label: Text("Custom")) {
                            ForEach(1..<366, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
                // END OF SECTION
            }
            // END OF FORM
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Repetition")
        }
        // END OF NAVIGATIONSTACK
    }
}

struct RepetitionView_Previews: PreviewProvider {
    static var previews: some View {
        RepetitionView()
    }
}
