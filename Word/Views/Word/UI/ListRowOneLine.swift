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
                Text("\(getText(input: "chinese"))")
                    .onTapGesture {
                        isShowChineseSingle.toggle()
                    }
                Text(word.name)
                    .font(.title3)
                    /// The hide action is realized by modifying the color.(`Color.clear`)
                    .foregroundColor((!isShowChinese)||isShowChineseSingle ? Color.black : Color.clear)
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
//                Spacer()
                Text("\(getText(input: "english"))")
                    .onTapGesture {
                        isShowEnglishSingle.toggle()
                    }
            }
        }
    }

    func getText(input: String) -> String {
        if !isShowEnglish && !isShowChinese {
            return ""
        } else if input=="chinese" && !isShowChinese {
            return ""
        } else if input=="chinese" && isShowChinese {
            return "◯"
        } else if input=="english" && !isShowEnglish {
            return ""
        } else if input=="english" && isShowEnglish {
            return "◯"
        } else {
            /// This situation would never appear.
            return "unknown"
        }
    }
}
