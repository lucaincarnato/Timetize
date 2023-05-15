//
//  ContainerView.swift
//  TimeTize
//
//  Created by Luca Maria Incarnato on 21/04/23.
//

import SwiftUI

struct ContainerView: View {
    var body: some View {
        TabView{
            // Calendar page
            DashboardView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Dashboard")
                }
            // Search page
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            // Settings page
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
