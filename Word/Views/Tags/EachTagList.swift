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
    
    @State var isEditMode: EditMode = .inactive
    @State var selectWordsID:Set<UUID> = []
    
    @State var SelectAllButtonText:String = "全选"
    
    var body: some View {
        VStack {
            List(selection: $selectWordsID) {
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
            .navigationBarTitle("\(tag)",displayMode: .inline)
            Divider()
            
            BottomViews(sortMode: $sortMode, filterTag: tag, isEditMode: $isEditMode, showEnglishOnly: $showEnglishOnly, showChineseOnly: $showChineseOnly, selectWordsID: $selectWordsID)
        }
        .toolbar(){
            ToolbarItem(placement: .primaryAction) {
                EditButton(isEditMode: $isEditMode)
            }
        }
        .environment(\.editMode, $isEditMode)
    }
}

struct EachTagList_Previews: PreviewProvider {
    static var previews: some View {
        EachTagList(tag:"作文")
    }
}
