//
//  PlanView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI

struct PlanView: View {
    
    @Environment (\.dismiss) var dismiss
    @ObservedObject var myData = sharedData
    
    var body: some View {
        NavigationStack {
            Form {
                Text("not ready")
            }
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Automatic planning")
            .toolbar {
                ToolbarItem{
                    Button("Done"){
                        print("Done")
                    }
                }
                ToolbarItem (placement: .cancellationAction){
                    Button ("Cancel"){
                        dismiss()
                    }
                    
                }
            }
        }//MARK: END NAV.STACK
    }}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
    }
}
