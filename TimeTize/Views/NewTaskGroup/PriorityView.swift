//
//  PriorityView.swift
//  TimeTize
//
//  Created by Alessia Di Gioia  on 22/04/23.
//

import SwiftUI

struct PriorityView: View {
    
    // Values and float index for the importance
    @State var indexOne: Float
    let importanceValues = ["Doesn't matter", "Matters", "Really Matters"]
    
    // Values and float index for the urgency
    @State var indexTwo: Float
    let urgencyValues = ["Could do", "Should do", "Must do"]
    
    // Values and float index for the usefulness
    @State var indexThree: Float
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
                // The circle shows the user what the priority will look like in the card
                Circle()
                    .frame(width: 100)
                    .padding(.horizontal,200)
                    .foregroundColor(Data().toColor(priority: Int(indexOne+indexTwo+indexThree)))
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
            PriorityView(indexOne: 0.0, indexTwo: 0.0, indexThree: 0.0)
        }
    }
}
