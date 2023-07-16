//
//  ContentView.swift
//  Word
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .search
    @StateObject private var modelData = ModelDataClass()
    enum Tab {
        case search
        case word
        case manage
        case setting
    }

    var body: some View {
        TabView(selection: $selection) {
            SearchView()
                .tabItem {
                    Label("search_tab", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)
            WordList()
                .tabItem {
                    Label("word_tab", systemImage: "list.bullet")
                }
                .tag(Tab.word)
            Manage()
                .tabItem {
                    Label("manage_tab", systemImage: "command.square")
                }
                .tag(Tab.manage)
            Setting()
                .tabItem {
                    Label("setting_tab", systemImage: "gearshape")
                }
                .tag(Tab.setting)
        }
//        .tabViewStyle(.page(indexDisplayMode: .always))
        .accentColor(Color.red) // tabview font color, default to blue
        .environmentObject(modelData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
