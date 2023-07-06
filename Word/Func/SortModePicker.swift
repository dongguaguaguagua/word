//
//  SortModePicker.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import SwiftUI

struct SortModePicker: View {
    @Binding var sortMode:SortMode
    var body: some View {
        Picker("sort", selection: $sortMode) {
            Text("从旧到新").tag(SortMode.byDateUp)
            Text("从新到旧").tag(SortMode.byDateDown)
            Text("从A到Z").tag(SortMode.byNameUp)
            Text("从Z到A").tag(SortMode.byNameDown)
            Text("随机打乱").tag(SortMode.random)
        }
    }
}
