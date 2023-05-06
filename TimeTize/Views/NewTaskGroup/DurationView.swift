//
//  DurationView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 27/04/23.
//

import SwiftUI

struct DurationView: View {
    
    @State var durationHours = 0
    @State var durationMinutes = 0
    
    var body: some View {
        NavigationStack {
            Form{
                Section("Chose task duration"){
                    Picker(selection: $durationMinutes, label: Text("Duration")) {
                        ForEach(0..<24, id: \.self) { i in
                            Text("\(i) hrs").tag(i)
                        }
                    }
                    .pickerStyle(.wheel)
                    Picker(selection: $durationHours, label: Text("Duration")) {
                        ForEach(0..<60, id: \.self) { i in
                            Text("\(i) min").tag(i)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
        }//MARK: END NAV.STACK
    }
}

struct DurationView_Previews: PreviewProvider {
    static var previews: some View {
        DurationView()
    }
}
