//
//  SearchView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 21/04/23.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""  // Placeholder text for the search field
    @ObservedObject var myData = sharedData
    @State var thisTask: PlannedTask?  // Placeholder task for the history
    @Environment(\.colorScheme) var colorScheme // System color for the dark mode
    
    // Function to format a Date to string
    func toString(format: String, dateSource: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: dateSource)
    }
    
    var body: some View {
        // START OF NAVIGATION STACK
        NavigationStack{
            // START OF ZSTACK for the background color
            ZStack {
                // Background color that fills the entire screen
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea()
                // START OF SCROLLVIEW
                ScrollView{
                    // START OF FOREACH to show all the tasks with the searched text
                    ForEach ($myData.tasks){ $task in
                        // Shows only the tasks that contains the written text
                        if(task.taskName.contains(searchText)){
                            // Task Card
                            Button {
                                if(!task.searched){
                                    task.searched.toggle()
                                }
                                self.thisTask = task
                            } label: {
                                CardView(name: task.taskName, start: toString(format: "YY/MM/dd hh:mm a", dateSource: task.taskStart), end: toString(format: "YY/MM/dd hh:mm a", dateSource: task.taskEnd), index: task.tagIndex, priority: task.priority)
                                    .foregroundColor(colorScheme == .light ? .white: .black)
                            }
                        }
                    }
                    // END OF FOREACH
                    // START OF SECTION for the history
                    Section{
                        Text("HISTORY")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        // START OF FOREACH to show all the searched tasks
                        ForEach(myData.tasks){ recent in
                            // Show task only if searched is true
                            if(recent.searched){
                                // Task card 
                                Button {
                                    self.thisTask = recent
                                } label: {
                                    CardView(name: recent.taskName, start: toString(format: "YY/MM/dd hh:mm", dateSource: recent.taskStart), end: toString(format: "YY/MM/dd hh:mm", dateSource: recent.taskEnd), index: recent.tagIndex, priority: recent.priority)
                                        .foregroundColor(colorScheme == .light ? .white: .black)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                }
                // END OF SCROLLVIEW
                .padding(.horizontal, 15)
                .padding(.vertical)
                
            }
            // END OF ZSTACK
            .navigationTitle("Search")
            // Sheet to show task information
            .sheet(item: $thisTask) { task in
                TaskInfoView(task: task)
            }
        }
        // END OF NAVIGATION STACK
        .searchable(text: $searchText)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
