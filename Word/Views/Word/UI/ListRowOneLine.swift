//
//  ListRowOneLine.swift
//  Word
//
//  Created by 胡宗禹 on 7/7/23.
//

import SwiftUI

struct ListRowOneLine: View {
    @EnvironmentObject var ModelData: ModelDataClass

    @Binding var isShowEnglish: Bool
    @Binding var isShowChinese: Bool

    /// whether show Chinese or English individually
    @State var isShowEnglishSingle: Bool=false
    @State var isShowChineseSingle: Bool=false

    /// receive a word
    var word: singleWord

    var body: some View {
        HStack {
            HStack {
                if showBtn(isChinese: true) {
                    Button(action: {
                        isShowChineseSingle.toggle()
                    }) {
                        Image(systemName: "poweroff")
                            .font(.system(size: 15))
                            .foregroundColor(.red)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                Text(word.name)
                    .font(.title3)
                    /// The hide action is realized by modifying the color.(`Color.clear`)
                    .foregroundColor((!isShowChinese) || isShowChineseSingle ? Color.black : Color.clear)
                    /// ease in and out animation
                    .animation(.easeInOut(duration: 0.2), value: isShowChineseSingle)
                    .lineLimit(1)
//                    .onTapGesture {
//                        let index=ModelData.word.firstIndex(where: { $0.id==word.id }) ?? 0
//                        ModelData.word[index].importance += 1
//                        saveData(data: ModelData.word)
//                    }
            }
            Spacer()
            HStack {
                Spacer()
                if word.definition == "" {
                    let DictWord=fetchDataFromWordName(word: word.name)
                    Text(DictWord.translation)
                        .font(.subheadline)
                        .foregroundColor((!isShowEnglish) || isShowEnglishSingle ? Color.gray : Color.clear)
                        .animation(.easeInOut(duration: 0.2), value: isShowEnglishSingle)
                        .lineLimit(1)
                } else {
                    Text(word.definition)
                        .font(.subheadline)
                        .foregroundColor((!isShowEnglish) || isShowEnglishSingle ? Color.gray : Color.clear)
                        .animation(.easeInOut(duration: 0.2), value: isShowEnglishSingle)
                        .lineLimit(1)
                }
                if showBtn(isChinese: false) {
                    Button(action: {
                        isShowEnglishSingle.toggle()
                    }) {
                        Image(systemName: "poweroff")
                            .font(.system(size: 15))
                            .foregroundColor(.red)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
//        .background(
//            LinearGradient(gradient: Gradient(colors: [.red, .white]), startPoint: .leading, endPoint: .trailing)
//                .frame(width: 50)
//        )
    }

    func showBtn(isChinese: Bool) -> Bool {
        if !isShowEnglish && !isShowChinese {
            return false
        }
        if isChinese && !isShowChinese {
            return false
        }
        if !isChinese && !isShowEnglish {
            return false
        }

        return true
    }
}
