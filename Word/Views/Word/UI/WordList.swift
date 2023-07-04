//
//  List.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI
import Foundation

struct WordList: View {
    @EnvironmentObject var ModelData:ModelDataClass

    ///中英文切换变量
    @State var showEnglishOnly:Bool=false
    @State var showChineseOnly:Bool=false
    
    ///`SortMode`包含四个case
    @State var sortMode:SortMode = .byDateDown
    
    ///过滤用标签
    @State var filterTag:String = "全部"

    @State var isEditMode: EditMode = .inactive
    @State var selectWordsID:Set<UUID> = []
    
    var body: some View {
        NavigationView{
            VStack {
                List(selection: $selectWordsID) {
                    ForEach(sortWords(sortMode: sortMode, data: filteredWords(data: ModelData.word, tag: filterTag))){
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
                .navigationTitle("生词本")
                Divider()
                BottomViews(sortMode: $sortMode, filterTag: filterTag, isEditMode: $isEditMode, showEnglishOnly: $showEnglishOnly, showChineseOnly: $showChineseOnly, selectWordsID: $selectWordsID)
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
                ///标签过滤器
                ToolbarItem(placement: .navigation) {
                    Picker("filter", selection: $filterTag) {
                        Text("全部").tag("全部")
                        Text("无标签").tag("无标签")
                        ForEach(ModelData.tag.map { $0.name },id: \.self){
                            tag in
                            Text(tag)
                        }
                    }
                }
            }
            .environment(\.editMode, $isEditMode)
        }
    }
}

struct List_Previews: PreviewProvider {
    static let modelData=ModelDataClass()
    static var previews: some View {
        WordList()
            .environmentObject(modelData)
    }
}
