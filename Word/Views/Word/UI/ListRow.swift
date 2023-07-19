//
//  ListRow.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

/// This is the navigation label of each single word.
/// It shows the word's name, definition. And provide button to hide or show them individually.
struct ListRow: View {
    @EnvironmentObject var ModelData: ModelDataClass

    @Binding var isShowEnglish: Bool
    @Binding var isShowChinese: Bool

    /// whether show Chinese or English individually
    @State var showMaskSingleWord: Bool = true

    /// receive a word
    var word: singleWord
    /// Views
    var wordNameView: some View {
        VStack(alignment: .leading) {
            Text(word.name)
                .font(.title2)
                .foregroundColor(Color.black)
                .padding(.bottom, 4)
            Text("[ "+fetchDataFromWordName(word: word.name).phonetic+" ]")
                .font(.system(size: 12))
                .foregroundColor(Color(red: 200/255, green: 200/255, blue: 200/255))
        }
        .frame(width: 150, height: 70, alignment: .leading)
    }

    var wordDifinitionView: some View {
        VStack(alignment: .leading) {
            if word.definition == "" {
                let DictWord = fetchDataFromWordName(word: word.name)
                Text(DictWord.translation)
                    .font(.system(size: 15))
                    .padding([.top, .bottom, .leading, .trailing], 2)
                    .foregroundColor(Color.gray)
            } else {
                Text(word.definition)
                    .font(.system(size: 15))
                    .padding([.top, .bottom, .leading, .trailing], 2)
                    .foregroundColor(Color.gray)
            }
        }
        .frame(width: 150, height: 70)
    }

    var clickAndShowButton: some View {
        VStack(alignment: .leading) {
            Text("点击显示")
                .font(.system(size: 15))
                .foregroundColor(Color.gray)
        }
        .frame(width: 150, height: 70, alignment: .center)
        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
        .cornerRadius(5)
    }

    var body: some View {
        HStack {
            if isShowChinese {
                if showMaskSingleWord {
                    clickAndShowButton
                        .onTapGesture {
                            showMaskSingleWord = !showMaskSingleWord
                        }
                } else {
                    wordNameView
                        .onTapGesture {
                            showMaskSingleWord = !showMaskSingleWord
                        }
                }
            } else {
                wordNameView
            }
            Spacer()
            if isShowEnglish {
                if showMaskSingleWord {
                    clickAndShowButton
                        .onTapGesture {
                            showMaskSingleWord = !showMaskSingleWord
                        }
                } else {
                    wordDifinitionView
                        .onTapGesture {
                            showMaskSingleWord = !showMaskSingleWord
                        }
                }
            } else {
                wordDifinitionView
            }
        }
    }
}

// struct ListRow_Previews: PreviewProvider {
//    static var word = ModelDataClass().word
//    static var previews: some View {
//        ListRow(word: word[0])
//            .environmentObject(ModelDataClass())
//    }
// }
