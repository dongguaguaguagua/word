//
//  Settings.swift
//  Word
//
//  Created by 胡宗禹 on 7/6/23.
//

import SwiftUI

struct Setting: View {
    @EnvironmentObject var ModelData: ModelDataClass
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("appearance")) {
                    Toggle(isOn: $ModelData.settings.moreCompactLayout) {
                        Text("more_compact_layout")
                    }
                }
                Section(header: Text("gesture")) {
                    Toggle(isOn: $ModelData.settings.clickBottomToShuffle) {
                        Text("click_bottom_to_shuffle")
                    }
                }
                Section(header: Text("auxiliary")) {
                    Toggle(isOn: $ModelData.settings.disableAutoCorrection) {
                        Text("disable_auto_correction")
                    }
                    Toggle(isOn: $ModelData.settings.enableMarkdown) {
                        Text("enable_markdown")
                    }
                    Toggle(isOn: $ModelData.settings.enableFuzzySearch) {
                        Text("enable_fuzzy_search")
                    }
                    Text("Fuzziness: \(String(format: "%0.1f",ModelData.settings.fuzziness))")
                    Slider(value: $ModelData.settings.fuzziness, in: 0 ... 1, step: 0.1)
                        .disabled(!ModelData.settings.enableFuzzySearch)
                }
            }.navigationTitle("Settings")
        }
    }
}

//
// struct Settings_Previews: PreviewProvider {
//    static var previews: some View {
//        Settings()
//    }
// }
