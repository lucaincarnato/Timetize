//
//  PlanView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI

struct PlanView: View {
    
    @Environment (\.dismiss) var dismiss    // Variable to dismiss the modal view
    @ObservedObject var myData = sharedData
    
    var body: some View {
        // START OF NAVIGATIONSTACK
        NavigationStack {
            Form {
                Text("not ready")
            }
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Automatic planning")
            // Button for the automatic planning
            .toolbar {
                ToolbarItem{
                    Button("Done"){
                        print("Done")
                    }
                }
                // Button to dismiss the modal view
                ToolbarItem (placement: .cancellationAction){
                    Button ("Cancel"){
                        dismiss()
                    }
                }
            }
        }
        // END OF NAVIGATIONSTACK
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
    }
}
