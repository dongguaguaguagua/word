//
//  NoTagList.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import SwiftUI

struct NoTagList: View {
    @EnvironmentObject var ModelData:ModelDataClass
    
    ///中英文切换变量
    @State var showEnglishOnly:Bool=false
    @State var showChineseOnly:Bool=false
    @State var showLanguage:String="隐藏中文"
    ///`SortMode`包含四个case
    @State var sortMode:SortMode = .byNameDown
    
    @State var isEditMode: EditMode = .inactive
    @State var selectWordsID:Set<UUID> = []
    @State var SelectAllButtonText:String = "全选"
    
    var noTagWord:[singleWord]{
        ModelData.word.filter({$0.tag==[]})
    }
    
    var body: some View {
        VStack{
            List(selection: $selectWordsID) {
                ForEach(sortWords(sortMode: sortMode, data: noTagWord)){
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
            .navigationBarTitle("无标签", displayMode: .inline)
            Divider()
            HStack {
                if(isEditMode == .inactive){
                    SortModePicker(sortMode: $sortMode)
                    Text("共计 \(noTagWord.count) ")
                        .bold()
                    ///切换中英文显示模式
                    Text("\(showLanguage)")
                        .padding()
                        .onTapGesture {
                            switchShowMode(Language: &showLanguage, showChineseOnly: &showChineseOnly, showEnglishOnly: &showEnglishOnly)
                        }
                }else{
                    Spacer()
                    NavigationLink{
                        SelectTagsForMutiWords(WordsID: selectWordsID)
                    }
                    label: {
                        Text("设置标签")
                            .font(.title3)
                    }
                    .disabled(selectWordsID.count == 0)
                    Spacer()
                    Button("删除"){
                        for id in selectWordsID{
                            ModelData.word.removeAll(where: {$0.id==id})
                        }
                        saveData(data: ModelData.word)
                    }
                    .font(.title3)
                    .foregroundColor(Color.red)
                    .disabled(selectWordsID.count == 0)
                    Spacer()
                    Button(SelectAllButtonText){
                        if(SelectAllButtonText=="全选"){
                            selectWordsID=Set(noTagWord.map { $0.id })
                            SelectAllButtonText="取消"
                        }else{
                            selectWordsID=[]
                            SelectAllButtonText="全选"
                        }
                    }
                    .font(.title3)
                    Spacer()
                }
            }
        }
        .toolbar(){
            ToolbarItem(placement: .primaryAction) {
                EditButton(isEditMode: $isEditMode)
            }
        }
        .environment(\.editMode, $isEditMode)
    }
}

struct NoTagList_Previews: PreviewProvider {
    static var previews: some View {
        NoTagList()
    }
}
