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
        case recite
        case manage
        case setting
    }

    init() {
        // configure blur background
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
        appearance.backgroundColor = UIColor(Color.white.opacity(0.2))

        // Use this appearance when scrolling behind the TabView:
        UITabBar.appearance().standardAppearance = appearance
        // Use this appearance when scrolled all the way up:
        UITabBar.appearance().scrollEdgeAppearance = appearance
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
            ReciteWordsView()
                .tabItem {
                    Label("recite_tab", systemImage: "chart.bar.xaxis")
                }
                .tag(Tab.recite)
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
        .accentColor(Color.red) // tabview font color, default to blue
        .environmentObject(modelData)
//        .onAppear {
//            guard let url = URL(string: "https://bing.biturl.top/?resolution=1920&format=json&index=0&mkt=en-US") else {
//                return
//            }
//            //    print(url)
//            URLSession.shared.dataTask(with: url) { data, _, _ in
//                if let data = data {
//                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                       let imageURLString = json["url"] as? String,
//                       let msg = json["copyright"] as? String,
//                       let imageURL = URL(string: imageURLString)
//                    {
//                        DispatchQueue.main.async {
//                            modelData.bingBackground.imageMsg = msg.components(separatedBy: "(©")[0]
//                        }
//                        if let imageData = try? Data(contentsOf: imageURL),
//                           let image = UIImage(data: imageData)
//                        {
//                            DispatchQueue.main.async {
//                                modelData.bingBackground.backgroundImage = image
//                            }
//                        }
//                    }
//                }
//            }.resume()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
