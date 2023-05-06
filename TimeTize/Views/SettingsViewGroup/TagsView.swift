//
//  TagsView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI

struct TagsView: View {
    
    @State var name = ""
    @State var color = Color.blue
    @ObservedObject var myData = sharedData
    
    var body: some View {
        NavigationStack {
            Form{
                Section("Add a new tag") {
                    TextField("Tag's name", text: $name)
                    ColorPicker("Tag's color", selection: $color)
                }
                Section("Existing tags"){
                    ForEach(myData.tags){ tag in
                        Text(tag.tagName)
                            .foregroundColor(tag.colro)
                    }
                    .onDelete { index in
                        myData.tags.remove(atOffsets: index)
                    }
                }
            }
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Tags")
        }//MARK: END NAV.STACK
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
    }
}
