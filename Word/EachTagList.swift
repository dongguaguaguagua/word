//
//  EachTagList.swift
//  Word
//
//  Created by 胡宗禹 on 6/26/23.
//

import SwiftUI

struct EachTagList: View {
    @EnvironmentObject var ModelData:ModelDataClass
    
    var tag:String
    
    ///中英文切换变量
    @State var showEnglishOnly:Bool=false
    @State var showChineseOnly:Bool=false
    @State var showLanguage:String="隐藏中文"
    ///`SortMode`包含四个case
    @State var sortMode:SortMode = .byNameDown

    var body: some View {
        VStack {
            List() {
                ForEach(sortWords(sortMode: sortMode, data: filteredWords(data: ModelData.word, tag: tag))){
                    word in
                    NavigationLink(){
                        ListDetail(word: word)
                    }
                    label: {
                    ListRow(isShowEnglish: $showEnglishOnly,isShowChinese:$showChineseOnly,word: word)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                ModelData.word.removeAll(where: {word.id==$0.id})
                                saveData(data: ModelData.word)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            HStack {
                Picker("sort", selection: $sortMode) {
                    Text("从旧到新").tag(SortMode.byDateUp)
                    Text("从新到旧").tag(SortMode.byDateDown)
                    Text("从A到Z").tag(SortMode.byNameUp)
                    Text("从Z到A").tag(SortMode.byNameDown)
                    Text("随机打乱").tag(SortMode.random)
                }
                Text("共计 \(getFilteredWordsCount(data:ModelData.word,tag:tag)) ")
                    .bold()
                ///切换中英文显示模式
                Text("\(showLanguage)")
                    .padding()
                    .onTapGesture {
                        switchShowMode()
                    }
            }
            Divider()
        }
        .navigationBarTitle("\(tag)",displayMode: .inline)
        .background(.ultraThinMaterial)
    }

    ///判断显示方案和按钮文字
    func switchShowMode(){
        switch showLanguage{
        case "隐藏中文":
            showChineseOnly=false
            showEnglishOnly=true
            showLanguage="隐藏英文"
            break
        case "隐藏英文":
            showChineseOnly=true
            showEnglishOnly=false
            showLanguage="中文英文"
            break
        case "中文英文":
            showChineseOnly=false
            showEnglishOnly=false
            showLanguage="隐藏中文"
            break
        default:
            showChineseOnly=false
            showEnglishOnly=false
            showLanguage="隐藏中文"
            break
        }
    }
}

//struct EachTagList_Previews: PreviewProvider {
//    static var previews: some View {
//        EachTagList("无标签")
//    }
//}
