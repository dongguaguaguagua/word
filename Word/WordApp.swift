//
//  WordApp.swift
//  Word
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

@main
struct WordApp: App {
    @StateObject private var modelData = ModelDataClass()
    var body: some Scene {
        WindowGroup {
            /// `.attachPartialSheetToRoot()` aims to make partial sheet easy to use everywhere.
            ContentView()
                .environment(\.locale, .init(identifier: "zh-Hans"))
//                .environment(\.locale, .init(identifier: "en"))
//            VipTest()
//            ReciteWordsView()
        }
    }
}
