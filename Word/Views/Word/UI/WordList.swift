//
//  List.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI
import Foundation

///The page of `word` tab.
struct WordList: View {
    @EnvironmentObject var ModelData:ModelDataClass

    ///The varables record whether to show English or Chinese.
    @State var showEnglishOnly:Bool=false
    @State var showChineseOnly:Bool=false
    
    ///`SortMode` has four cases, and default is `byDateDown`
    @State var sortMode:SortMode = .byDateDown
    
    ///Tag to filter, and default is `All`
    @State var filterTag:String = "全部"

    @State var isEditMode: EditMode = .inactive
    
    ///A set that contains the selected word's UUID
    @State var selectWordsID:Set<UUID> = []
    
    var body: some View {
        NavigationView{
            ///Plan to use `lazyStack` instead
            VStack {
                List(selection: $selectWordsID) {
                    ForEach(sortWords(sortMode: sortMode, data: filteredWords(data: ModelData.word, tag: filterTag))){
                        word in
                        NavigationLink(){
                            ListDetail(word: word)
                        }
                    label: {
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
                        }
                    }
                }
                .navigationTitle("生词本")
                Divider()
                ///The bottom view.
                BottomViews(sortMode: $sortMode, filterTag: filterTag, isEditMode: $isEditMode, showEnglishOnly: $showEnglishOnly, showChineseOnly: $showChineseOnly, selectWordsID: $selectWordsID)
            }
            .toolbar(){
                ///Apple provide `EditButton()` to switch edit mode.
                ///But unfortunately, this Button is currently **not customizable**
                ///You have no way to change the button's text or something.
                ///You can also use your own edit button:
                ///```swift
                ///Button(isEditMode.isEditing ? "完成": "编辑") {
                ///switch isEditMode {
                ///    case .active:
                ///         self.isEditMode = .inactive
                ///    case .inactive:
                ///         self.isEditMode = .active
                ///    default:
                ///         break
                ///    }
                ///}
                ///```
                ///But the button has no animation. It is not what I want.
                ///So I have no way but let `text` overlap with `EditButton()`.
                ToolbarItem(placement: .primaryAction) {
                    Text(isEditMode.isEditing ? "完成": "编辑")
                        .foregroundColor(Color.blue)
                        .offset(x:40,y:0)
                }
                ToolbarItem(placement: .primaryAction) {
                    EditButton()
                        .accentColor(.clear)
                }
                ///Tag picker
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
