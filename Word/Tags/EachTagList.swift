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
        List() {
            ForEach(sortWords(sortMode: sortMode, data: filteredWords(data: ModelData.word, tag: tag))){
                word in
                if(word.isShow){
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
        }
        .navigationBarTitle("\(tag)",displayMode: .inline)
        
        HStack {
            SortModePicker(sortMode: $sortMode)
            Text("共计 \(getFilteredWordsCount(data:ModelData.word,tag:tag)) ")
                .bold()
            ///切换中英文显示模式
            Text("\(showLanguage)")
                .padding()
                .onTapGesture {
                    switchShowMode(Language: &showLanguage, showChineseOnly: &showChineseOnly, showEnglishOnly: &showEnglishOnly)
                }
        }
        Divider()
    }
}

struct EachTagList_Previews: PreviewProvider {
    static var previews: some View {
        EachTagList(tag:"作文")
    }
}
