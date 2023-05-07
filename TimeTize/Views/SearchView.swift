//
//  SearchView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 21/04/23.
//

import SwiftUI

struct SearchView: View {
    
    @State var shouldShowNewTaskView = false
    @State var shouldShowSettingsView = false
    @State private var searchText = ""
    @ObservedObject var myData = sharedData
    @State var task: Task?
    @Environment(\.colorScheme) var colorScheme
    
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
                    ForEach ($myData.tasks){ $task in
                        if(task.taskName.contains(searchText)){
                            Button {
                                if(!task.searched){
                                    task.searched.toggle()
                                }
                                self.task = task
                            } label: {
                                CardView(name: task.taskName, hour: task.taskRange, tag: task.tagName, priority: 3)
                                    .foregroundColor(colorScheme == .light ? .white: .black)
                            }
                            // END OF ZSTACK
                        }
                    }
                    Section{
                        Text("HISTORY")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        ForEach(myData.tasks){ recent in
                            if(recent.searched){
                                Button {
                                    self.task = recent
                                } label: {
                                    CardView(name: recent.taskName, hour: recent.taskRange, tag: recent.tagName, priority: 3)
                                        .foregroundColor(colorScheme == .light ? .white: .black)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                }
                .padding(.horizontal, 15)
                .padding(.vertical)
                // END OF SCROLLVIEW
                
            }
            .navigationTitle("Search")
            .sheet(item: $task) { task in
                TaskInfoView(task: task)
            }
            // END OF ZSTACK
        }
        .searchable(text: $searchText)
        // END OF NAVIGATION STACK
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
