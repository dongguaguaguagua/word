//
//  Imortance.swift
//  Word
//
//  Created by 胡宗禹 on 7/17/23.
//

import SwiftUI
import WrappingHStack

struct ImportanceRank: View {
    var DictWord: DictStruct
    var body: some View {
        let bncRankExists: Bool = DictWord.bnc > 0
        let collinsExists: Bool = DictWord.collins > 0
        let frequencyExists: Bool = DictWord.frq > 0
        let oxfordExists: Bool = DictWord.oxford > 0
        let wordTags: String = DictWord.tag
        let color1 = Color(red: 101/255, green: 102/255, blue: 246/255)
        let color2 = Color(red: 112/255, green: 117/255, blue: 51/255)
        let color3 = Color(red: 215/255, green: 52/255, blue: 45/255)
        let color4 = Color(red: 78/255, green: 159/255, blue: 215/255)
        let color5 = Color(red: 238/255, green: 113/255, blue: 69/255)
        if bncRankExists || collinsExists || frequencyExists || oxfordExists || wordTags != "" {
            Section(header: Text("importance")) {
                HStack {
                    if collinsExists {
                        Text("collins")
                            .font(.system(size: 10))
                            .padding([.trailing, .leading, .top, .bottom], 3)
                            .foregroundColor(color4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .stroke(color4, lineWidth: 1)
                            )
                            .padding(.trailing, 5)
                        ForEach(1 ... 5, id: \.self) { index in
                            Image(systemName: index <= DictWord.collins ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .font(.system(size: 10))
//                                    .background(.gray)
                                .padding(.leading, -10)
                        }
                    }
                    if bncRankExists {
                        Text("BNC")
                            .font(.system(size: 10))
                            .padding([.trailing, .leading, .top, .bottom], 3)
                            .foregroundColor(color1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .stroke(color1, lineWidth: 1)
                            )
                        Text(String(DictWord.bnc))
                            .foregroundColor(color1)
                    }
                    if frequencyExists {
                        Text("frequency")
                            .font(.system(size: 10))
                            .padding([.trailing, .leading, .top, .bottom], 3)
                            .foregroundColor(color2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .stroke(color2, lineWidth: 1)
                            )
                        Text(String(DictWord.frq))
                            .foregroundColor(color2)
                    }
                }
                if oxfordExists || wordTags != "" {
                    WrappingHStack(alignment: .leading) {
                        if oxfordExists {
                            Text("Oxford_3000")
                                .font(.system(size: 10))
                                .padding([.trailing, .leading, .top, .bottom], 3)
                                .foregroundColor(color5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                                        .stroke(color5, lineWidth: 1)
                                )
                        }
                        if wordTags != "" {
                            let tagList: [String] = wordTags.components(separatedBy: " ")
                            ForEach(tagList, id: \.self) { wordTag in
                                Text(LocalizedStringKey(wordTag))
                                    .font(.system(size: 10))
                                    .padding([.trailing, .leading, .top, .bottom], 3)
                                    .foregroundColor(color3)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                                            .stroke(color3, lineWidth: 1)
                                    )
                            }
                        }
                    }
                }
            }
        }
    }
}
