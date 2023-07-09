//
//  NoTagList.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import SwiftUI

///This is no tag word list
///It's main difference between `EachTagList` is that the no tag word data is stored in `noTagWord`.
///while the `EachTagList` is stored in `ModelData` and filter it according to tags
struct NoTagList: View {
    @EnvironmentObject var ModelData:ModelDataClass
    
    ///中英文切换变量
    @State var showEnglishOnly:Bool=false
    @State var showChineseOnly:Bool=false
    @State var showLanguage:String="hide_native_language"
    ///`SortMode`包含四个case
    @State var sortMode:SortMode = .byNameDown
    
    @State var isEditMode: EditMode = .inactive
    @State var selectWordsID:Set<UUID> = []
    @State var SelectAllButtonText:String = "select_all"
    
    var noTagWord:[singleWord]{
        ModelData.word.filter({$0.tag==[]})
    }
    
    var body: some View {
        VStack{
            List(selection: $selectWordsID) {
                ForEach(sortWords(sortMode: sortMode, data: noTagWord)){
                    word in
                    ZStack(alignment: .leading){
                        if(ModelData.settings.showDetailDefinition){
                            ListRow(isShowEnglish: $showEnglishOnly,isShowChinese:$showChineseOnly,word: word)
                            ///`swipeActions` only available in `iOS 15.0, macOS 12.0` or later.
                            ///To support `iOS 14.0` and ealier, use https://github.com/SwipeCellKit/SwipeCellKit
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        ModelData.word.removeAll(where: {word.id==$0.id})
                                        saveData(data: ModelData.word)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }else{
                            ListRowOneLine(isShowEnglish: $showEnglishOnly,isShowChinese:$showChineseOnly,word: word)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        ModelData.word.removeAll(where: {word.id==$0.id})
                                        saveData(data: ModelData.word)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }

                        NavigationLink(destination: ListDetail(selectWordsID: $selectWordsID,word: word)){
                            EmptyView()
                        }.opacity(0.0)
                    }
                }
            }
            .navigationBarTitle("no_tag_title", displayMode: .inline)
            Divider()
            HStack() {
                if(isEditMode == .inactive){
                    HStack{
                        Spacer()
                        SortModePicker(sortMode: $sortMode)
                        Spacer()
                        Text("共计 \(noTagWord.count) ")
                            .bold()
                        Spacer()
                        ///切换中英文显示模式
                        Text("\(showLanguage)")
                            .onTapGesture {
                                switchShowMode(Language: &showLanguage, showChineseOnly: &showChineseOnly, showEnglishOnly: &showEnglishOnly)
                            }
                        Spacer()
                    }
                    .transition(.asymmetric(insertion: .backslide, removal: .slide  ))
                }else{
                    HStack{
                        Spacer()
                        NavigationLink{
                            SelectTagsForMutiWords(WordsID: selectWordsID)
                        }
                        label: {
                            Text("select_tags")
                        }
                        .disabled(selectWordsID.count == 0)
                        Spacer()
                        Button("delete"){
                            for id in selectWordsID{
                                ModelData.word.removeAll(where: {$0.id==id})
                            }
                            saveData(data: ModelData.word)
                        }
                        .disabled(selectWordsID.count == 0)
                        Spacer()
                        Button(SelectAllButtonText){
                            if(SelectAllButtonText=="select_all"){
                                selectWordsID=Set(noTagWord.map { $0.id })
                                SelectAllButtonText="cancel"
                            }else{
                                selectWordsID=[]
                                SelectAllButtonText="select_all"
                            }
                        }
                        Spacer()
                    }
                    .offset(x:0,y:7)
                    .transition(.asymmetric(insertion: .slide, removal: .backslide))
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 5,
                maxHeight: 30,
                alignment: .topLeading
            )
            .animation(.default,value: isEditMode)
    //        .offset(x:0,y:20)
            Divider()
        }
        .toolbar(){
            ///edit button
            ToolbarItem(placement: .primaryAction) {
                Text(isEditMode.isEditing ? "done": "edit")
                    .foregroundColor(Color.blue)
                    .offset(x:40,y:0)
            }
            ToolbarItem(placement: .primaryAction) {
                EditButton()
                    .accentColor(.clear)
            }
        }
        .environment(\.editMode, $isEditMode)
    }
}

//struct NoTagList_Previews: PreviewProvider {
//    static var previews: some View {
//        NoTagList()
//    }
//}
