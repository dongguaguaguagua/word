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
            Text("old_to_new").tag(SortMode.byDateUp)
            Text("new_to_old").tag(SortMode.byDateDown)
            Text("A_to_Z").tag(SortMode.byNameUp)
            Text("Z_to_A").tag(SortMode.byNameDown)
//            Text("random").tag(SortMode.random)
        }
    }
}
