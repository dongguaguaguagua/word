//
//  ContentView.swift
//  Word
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .word
    @StateObject private var modelData=ModelDataClass()
    enum Tab {
        case word
        case manage
        case setting
    }
    var body: some View {
        TabView(selection: $selection){
            WordList()
                .tabItem{
                    Label("Word",systemImage: "list.bullet")
                }
                .tag(Tab.word)
            Manage()
                .tabItem{
                    Label("Manage",systemImage: "command.square")
                }
                .tag(Tab.manage)
            Setting()
                .tabItem{
                    Label("Setting",systemImage: "gearshape")
                }
                .tag(Tab.setting)
        }
        .environmentObject(modelData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
