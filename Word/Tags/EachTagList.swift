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
            
            HStack() {
                if(isEditMode == .inactive){
                    Spacer()
                    SortModePicker(sortMode: $sortMode)
                    Spacer()
                    Text("共计 \(getFilteredWordsCount(data:ModelData.word,tag:tag)) ")
                        .bold()
                    Spacer()
                    ///切换中英文显示模式
                    Text("\(showLanguage)")
                        .onTapGesture {
                            switchShowMode(Language: &showLanguage, showChineseOnly: &showChineseOnly, showEnglishOnly: &showEnglishOnly)
                        }
                    Spacer()
                }
                else{
                    Spacer()
                    NavigationLink{
                        SelectTagsForMutiWords(WordsID: selectWordsID)
                    }
                    label: {
                        Text("设置标签")
                    }
                    .disabled(selectWordsID.count == 0)
                    Spacer()
                    Button("删除"){
                        for id in selectWordsID{
                            ModelData.word.removeAll(where: {$0.id==id})
                        }
                        print(selectWordsID)
                        saveData(data: ModelData.word)
                    }
                    .foregroundColor(Color.red)
                    .disabled(selectWordsID.count == 0)
                    Spacer()
                    Button(SelectAllButtonText){
                        if(SelectAllButtonText=="全选"){
                            selectWordsID=Set(ModelData.word.map { $0.id })
                            SelectAllButtonText="取消"
                        }else{
                            selectWordsID=[]
                            SelectAllButtonText="全选"
                        }
                    }
                    Spacer()
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 5,
                maxHeight: 30,
                alignment: .topLeading
            )
            Divider()
        }
        .toolbar(){
            ///编辑按钮
            ToolbarItem(placement: .primaryAction) {
                /// https://juejin.cn/post/6983640370403868702
                Button(isEditMode.isEditing ? "完成": "编辑") {
                    switch isEditMode {
                    case .active:
                        self.isEditMode = .inactive
                    case .inactive:
                        self.isEditMode = .active
                    default:
                        break
                    }
                }
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
