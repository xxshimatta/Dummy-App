//
//  ContentView.swift
//  dummyapp
//
//  Created by Jeffrey Clay Setiawan on 02/03/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            CollectionListView()
                .tabItem {
                    Label("Collections", systemImage: "list.dash")
                }
            OrderListView()
                .tabItem {
                    Label("Orders", systemImage: "bag")
                }
        }
        .padding()
    }
}
