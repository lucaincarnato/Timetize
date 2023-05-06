//
//  WallpaperAlertView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI
import PhotosUI

struct WallpaperAlertView: View {
    
    @State var selectedItem: PhotosPickerItem?
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .top){
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea()
                VStack{
                    ZStack{
                        Image("placeholder")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .aspectRatio(contentMode: .fill)
                        Rectangle()
                            .frame(width: 210, height: 375)
                            .cornerRadius(20)
                    }
                    PhotosPicker(selection: $selectedItem, matching: .images){
                        Text("Chose image notification")
                    }
                }
                .padding(.vertical, 50)
                .navigationTitle("Image notification")
            }//MARK: END NAV.STACK
        }
    }
    
    
    struct WallpaperAlertView_Previews: PreviewProvider {
        static var previews: some View {
            WallpaperAlertView()
        }
    }
}
