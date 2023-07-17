//
//  Imortance.swift
//  Word
//
//  Created by 胡宗禹 on 7/17/23.
//

import SwiftUI

struct Importance: View {
    var DictWord:DictStruct
    var body: some View {
        Section(header: Text("Importance")) {
            StarRatingView(rating: DictWord.collins)
            HStack {
                Text("Bnc Rank")
                    .foregroundColor(Color.blue)
                Spacer()
                Text(String(DictWord.bnc))
                    .foregroundColor(Color.black)
            }
        }
    }
}
