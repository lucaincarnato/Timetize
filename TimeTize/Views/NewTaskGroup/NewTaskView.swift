//
//  NewTaskView.swift
//  TimeTize
//
//  Created by Alessia Di Gioia  on 22/04/23.
//

import SwiftUI

struct NewTaskView: View {
    
    @State var name: String = ""
    @State private var shouldFreeze = false
    @State private var shouldAllowNotifications = false
    @State var start: Date = Date()
    @State var end: Date = Date()
    @State var range: String = ""
    @State var rStart: Date = Date()
    @State var rEnd: Date = Date()
    @State var index = 0
    @State var shouldPlan = false
    
    @State var nTasks = 1
    
    @ObservedObject var myData = sharedData
    @State var shouldHideNewTaskView = false
    @Environment (\.dismiss) var dismiss
    
    func toString(format: String, dateSource: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: dateSource)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach(myData.newTasks){ task in
                    QuestionsView(name: $name, shouldFreeze: $shouldFreeze, shouldAllowNotifications: $shouldAllowNotifications, start: $start, end: $end, index: $index, nTasks: $nTasks, tags: $myData.tags)
                }
                .onDelete { task in
                    myData.newTasks.remove(atOffsets: task)
                }
                Button("Add new task") {
                    myData.newTasks.append(Task(taskName: "", taskStart: Date(), taskEnd: Date(), taskRange: "", repStart: Date(), repEnd: Date(), notification: false, tagName: "", searched: false))
                }.padding(.leading, 100.0)
            }//MARK: END FORM
            .background(.gray.opacity(0.1))
            .scrollContentBackground(.hidden)
            .navigationTitle("Planning")
            .toolbar {
                ToolbarItem (placement: .cancellationAction){
                    Button ("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem{
                    Button ("Done") {
                        myData.tasks.append(
                            Task(
                                taskName: name,
                                taskStart: start,
                                taskEnd: end,
                                taskRange: toString(format: "hh:mm", dateSource: start) + "-" + toString(format: "hh:mm", dateSource: end),
                                repStart: rStart,
                                repEnd: rEnd,
                                notification: false,
                                tagName: myData.tags[index].tagName,
                                searched: false
                            )
                        )
                        shouldPlan = true
                    }
                }
            }
            .sheet(isPresented: $shouldPlan){
                PlanView()
            }
        }//MARK: END NAV.STACK
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
