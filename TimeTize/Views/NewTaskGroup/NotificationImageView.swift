//
//  WallpaperAlertView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 26/04/23.
//

import SwiftUI
import PhotosUI
import UserNotifications


struct NotificationImageView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State var selectedImage: Image?
    
    
    var body: some View {
        // START OF NAVIGATIONSTACK
        NavigationStack {
            ZStack (alignment: .top){
                // Background color that fills up the entire screen
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea()
                VStack {
                    Text("Notification preview")
                    ZStack{
                        Image("Notification")
                            .resizable()
                            .frame(width: 370, height: 240)
                        if let selectedImage{
                            selectedImage
                                .resizable()
                                .frame(width: 370, height: 174)
                                .padding(.top, 66)
                                .cornerRadius(20)
                        } else {
                            Rectangle()
                                .fill(.white)
                                .frame(width: 370, height: 174)
                                .padding(.top, 66)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.vertical, 10)
                    PhotosPicker(selection: $selectedItem, matching: .any(of: [.images, .not(.videos)])) {
                        Label("Select a photo", systemImage: "photo.artframe")
                    }
                    .onChange(of: selectedItem) { newValue in
                        Task {
                            if let imageData = try? await newValue?.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                                selectedImage = Image(uiImage: image)
                            }
                        }
                    }
                }
                .padding(.vertical, 40)
            }
            .navigationTitle("Notification image")
        }
        // END OF NAVIGATIONSTACK
    }
    
    
    struct WallpaperAlertView_Previews: PreviewProvider {
        static var previews: some View {
            NotificationImageView()
        }
    }
}
