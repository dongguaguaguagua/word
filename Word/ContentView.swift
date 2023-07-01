//
//  ContentView.swift
//  Word
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI
import PartialSheet

struct ContentView: View {
    @State private var selection: Tab = .word
    @StateObject private var modelData=ModelDataClass()
    enum Tab {
        case word
        case manage
    }
    var body: some View {
        TabView(selection: $selection){
            WordList()
                .environmentObject(modelData)
                .tabItem{
                    Label("Word",systemImage: "list.bullet")
                }
                .tag(Tab.word)
            Manage()
                .environmentObject(modelData)
                .tabItem{
                    Label("Manage",systemImage: "command.square")
                }
                .tag(Tab.manage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
