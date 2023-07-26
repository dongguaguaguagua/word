//
//  deleteButton.swift
//  Word
//
//  Created by 胡宗尧 on 7/25/23.
//

import SwiftUI

struct deleteWordButton: View {
    @EnvironmentObject var ModelData: ModelDataClass
    let id:UUID
    var body: some View {
        Button(role: .destructive) {
            ModelData.word.removeAll(where: { id == $0.id })
            removeWordsInSql(uuid: [id])
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}
