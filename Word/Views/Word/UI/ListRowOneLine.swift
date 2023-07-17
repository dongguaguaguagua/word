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
            }
            Spacer()
            HStack {
                Spacer()
                Text(word.definition)
                    .font(.subheadline)
                    .foregroundColor((!isShowEnglish) || isShowEnglishSingle ? Color.gray : Color.clear)
                    .animation(.easeInOut(duration: 0.2), value: isShowEnglishSingle)
                    .lineLimit(1)
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
