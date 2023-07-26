//
//  DeleteForMutiWords.swift
//  Word
//
//  Created by 胡宗禹 on 7/2/23.
//

import SwiftUI

struct DeleteForMutiWords: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @State var WordsID: Set<UUID>

    var body: some View {
        Button("delete") {
            for id in WordsID {
                ModelData.word.removeAll(where: { $0.id == id })
            }
            removeWordsInSql(uuid: WordsID)
        }
    }
}

struct DeleteForMutiWords_Previews: PreviewProvider {
    static var previews: some View {
        DeleteForMutiWords(WordsID: [])
    }
}
