//
//  CardView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 28/04/23.
//

import SwiftUI

struct CardView: View {
    
    var name: String
    var hour: String
    var tag: String
    var priority: Int
    @State var showInfo: Bool = false
    
    var body: some View {
        
        // START OF ZSTACH for the single card
        ZStack (){
            // Card container
            Rectangle()
//                .colorInvert() // Property to allow color changes with dark mode
            // START OF HSTACK for the horizontal elements
            HStack{
                // Left line
                Rectangle()
                    .foregroundColor(.gray) // Property to allow color changes with dark mode
                    .frame(width: 5, height: 50)
                    .cornerRadius(10)
                    .opacity(0.4)
                // START OF VSTACK for vertical text
                VStack (alignment: .leading){
                    Text(name)
                        .font(.title3)
                        .bold()
                        .frame(width: 150, height: 20, alignment: .leading) // To make the name overflow
                    Text(hour)
                        .font(.subheadline)
                        .frame(width: 90, alignment: .leading)
                }
                .foregroundColor(.primary)
                .padding(.vertical)
                .padding(.horizontal)
                // END OF VSTACK
                // START OF ZSTACK for the tag
                ZStack{
                    // Container
                    Rectangle()
                        .fill(.gray)
                        .opacity(0.4)
                        .frame(width: 100, height: 35)
                        .cornerRadius(30)
                        .padding(.horizontal)
                    Text(tag)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 1)
                // END OF ZSTACK
                // END OF ZSTACK
            }
            // END OF HSTACK
            
        }
        .cornerRadius(20)
//        .sheet(isPresented: $showInfo){
//            TaskInfoView(task: <#Task#>)
//        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(name: "Giusy", hour: "8:00-12:00", tag: "Tag", priority: 3)
    }
}
