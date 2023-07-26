//
//  ReviewWordsView.swift
//  Word
//
//  Created by 胡宗尧 on 7/25/23.
//

import SwiftUI

func getWordsToReview() -> [String] {
    return ["hello", "world", "small", "black", "chicken"]
}

struct ReviewWordsView: View {
    var body: some View {
        let words: [String] = getWordsToReview()
    }
}

struct ReviewWordsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewWordsView()
    }
}
