//
//  PriorityView.swift
//  TimeTize
//
//  Created by Alessia Di Gioia  on 22/04/23.
//

import SwiftUI

struct PriorityView: View {
    
    @State var indexOne = 0.0
    let importanceValues = ["Doesn't matter", "Matters", "Really Matters"]
    
    @State var indexTwo = 0.0
    let urgencyValues = ["Could do", "Should do", "Must do"]
    
    @State var indexThree = 0.0
    let usefulnessValues = ["Not useful", "Useful", "Very useful"]
    
    
    var body: some View {
        NavigationStack {
            Form {
                /*
                Section {
                    Picker(selection: $index, label: Text("IMPORTANCE")) {
                        ForEach(0..<importanceValues.count) {
                            Text(self.importanceValues[$0]).tag($0)
                        }
                    }.pickerStyle(.inline)
                }//END IMPORTANCE
                
                Section {
                    Picker(selection: $indexTwo, label: Text("URGENCY")) {
                        ForEach(0..<urgencyValues.count) {
                            Text(self.urgencyValues[$0]).tag($0)
                        }
                    }.pickerStyle(.inline)
                }//END URGENCY
                
                Section {
                    Picker(selection: $indexThree, label: Text("USEFULNESS")) {
                        ForEach(0..<usefulnessValues.count) {
                            Text(self.usefulnessValues[$0]).tag($0)
                        }
                    }.pickerStyle(.inline)
                    
                }// END USEFULNESS
                 */
                Section{
                    Text("IMPORTANCE: " + importanceValues[Int(indexOne)])
                    Slider(value: $indexOne, in: 0...2, step: 1)
                }
                Section{
                    Text("URGENCE: " + urgencyValues[Int(indexTwo)])
                    Slider(value: $indexTwo, in: 0...2, step: 1)
                }
                Section{
                    Text("USEFULNESS: " + usefulnessValues[Int(indexThree)])
                    Slider(value: $indexThree, in: 0...2, step: 1)
                }
                
            }//MARK: END FORM
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Priority")
        }//MARK: END NAV.STACK
    }


    struct PriorityView_Previews: PreviewProvider {
        static var previews: some View {
            PriorityView()
        }
    }
}
