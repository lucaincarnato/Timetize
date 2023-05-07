//
//  CardView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 28/04/23.
//

import SwiftUI

struct CardView: View {
    
    var name: String    // Placeholder name
    var hour: String    // Placeholder hour
    var tag: String     // Placeholder tag
    var priority: Int   // Placeholder priority
    
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
                    .frame(width: 5, height: 50)
                    .cornerRadius(10)
                    .opacity(0.4)
                // START OF VSTACK
                VStack (alignment: .leading){
                    Text(name)
                        .font(.title3)
                        .bold()
                        .frame(width: 150, height: 20, alignment: .leading) // To make the name overflow
                    Text(hour)
                        .font(.subheadline)
                        .frame(width: 90, alignment: .leading)
                }
                // END OF VSTACK
                .foregroundColor(.primary)
                .padding(.vertical)
                .padding(.horizontal)
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
                // END OF ZSTACK
                .padding(.horizontal, 1)
            }
            // END OF HSTACK
        }
        // END OF ZSTACK
        .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(name: "Giusy", hour: "8:00-12:00", tag: "Tag", priority: 3)
    }
}
