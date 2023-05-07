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
        // START OF NAVIGATIONSTACK
        NavigationStack {
            Text("Wallpaper not ready yet")
        }
        // END OF NAVIGATIONSTACK
    }
    
    
    struct WallpaperAlertView_Previews: PreviewProvider {
        static var previews: some View {
            WallpaperAlertView()
        }
    }
}
