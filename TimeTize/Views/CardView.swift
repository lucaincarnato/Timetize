//
//  CardView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 28/04/23.
//

import SwiftUI

struct CardView: View {
    
    var name: String    // Placeholder name
    var start: String   // Placeholder start
    var end: String    // Placeholder end
    var tag: String     // Placeholder tag
    var priority: Int   // Placeholder priority
    
    // Function to assign each priority value a color
    func toColor(priority: Int)->Color{
        switch(priority){
        case 0:
            return Color.blue
        case 1:
            return Color.cyan
        case 2:
            return Color.teal
        case 3:
            return Color.green
        case 4:
            return Color.yellow
        case 5:
            return Color.orange
        case 6:
            return Color.red
        default:
            return Color.gray
        }
    }
    
    var body: some View {
        // START OF ZSTACH
        ZStack{
            // Card container
            Rectangle()
            // START OF HSTACK
            HStack{
                // Left line
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 5, height: 60)
                    .cornerRadius(10)
                    .opacity(0.4)
                    .padding(.horizontal,10)
                // START OF VSTACK
                VStack (alignment: .leading){
                    Text(name)
                        .font(.title3)
                        .bold()
                        .frame(width: 170, height: 20, alignment: .leading) // To make the name overflow
                    HStack{
                        Text("Start: ").bold() + Text(start)
                    }
                        .font(.subheadline)
                        .frame(width: 190, alignment: .leading)
                    HStack{
                        Text("End: ").bold() + Text(end)
                    }
                    .font(.subheadline)
                    .frame(width: 190, alignment: .leading)
                    .padding(.bottom,1)
                }
                // END OF VSTACK
                .foregroundColor(.primary)
                .padding(.vertical)
                // START OF ZSTACK for the tag
                ZStack{
                    // Container
                    Rectangle()
                        .fill(.gray)
                        .opacity(0.4)
                        .frame(width: 100, height: 35)
                        .cornerRadius(30)
                    Text(tag)
                        .foregroundColor(.white)
                }
                // END OF ZSTACK
                Circle()
                    .frame(width: 35)
                    .foregroundColor(toColor(priority: priority))
                    .padding(.horizontal,2)
            }
            // END OF HSTACK
        }
        // END OF ZSTACK
        .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(name: "Giusy", start: "12/10/23 8:00-12:00", end: "12/10/23 8:00-12:00", tag: "Tag", priority: 3)
    }
}
