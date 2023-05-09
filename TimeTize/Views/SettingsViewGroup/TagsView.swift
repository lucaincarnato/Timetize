//
//  TagsView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI

struct TagsView: View {
    
    @State var name = ""    // Placeholder text for the new tag
    @ObservedObject var myData = sharedData
    
    var body: some View {
        // START OF NAVIGATIONSTACK
        NavigationStack {
            // START OF FORM for all the tags
            Form{
                // START OF SECTION for the new task
                Section("Add a new tag") {
                    TextField("Tag's name", text: $name)
                }
                .onSubmit {
                    myData.tags.append(Tag(tagName: name))
                }
                // END OF SECTION
                // START OF SECTION for the existing tags
                Section("Existing tags"){
                    ForEach(myData.tags){ tag in
                        Text(tag.tagName)
                    }
                    .onDelete { tag in
                        myData.tags.remove(atOffsets: tag)
                    }
                }
                // END OF SECTION
            }
            // END OF FORM
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Tags")
        }
        // END OF NAVIGATION STACK
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
    }
}
