//
//  PriorityView.swift
//  TimeTize
//
//  Created by Alessia Di Gioia  on 22/04/23.
//

import SwiftUI

struct PriorityView: View {
    
    // Values and float index for the importance
    @State var indexOne = 0.0
    let importanceValues = ["Doesn't matter", "Matters", "Really Matters"]
    
    // Values and float index for the urgency
    @State var indexTwo = 0.0
    let urgencyValues = ["Could do", "Should do", "Must do"]
    
    // Values and float index for the usefulness
    @State var indexThree = 0.0
    let usefulnessValues = ["Not useful", "Useful", "Very useful"]
    
    
    var body: some View {
        // START OF NAVIGATIONSTACK
        NavigationStack {
            // START OF FORM for the three sliders
            Form {
                // Sliders for the importance
                Section{
                    Text("IMPORTANCE: " + importanceValues[Int(indexOne)])
                    Slider(value: $indexOne, in: 0...2, step: 1)
                }
                // Sliders for the urgence
                Section{
                    Text("URGENCE: " + urgencyValues[Int(indexTwo)])
                    Slider(value: $indexTwo, in: 0...2, step: 1)
                }
                // Sliders for the usefulness
                Section{
                    Text("USEFULNESS: " + usefulnessValues[Int(indexThree)])
                    Slider(value: $indexThree, in: 0...2, step: 1)
                }
            }
            // END OF FORM
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Priority")
        }
        // END OF NAVIGATIONSTACK
    }

    struct PriorityView_Previews: PreviewProvider {
        static var previews: some View {
            PriorityView()
        }
    }
}
