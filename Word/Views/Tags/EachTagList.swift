//
//  EachTagList.swift
//  Word
//
//  Created by 胡宗禹 on 6/26/23.
//

import SwiftUI

struct EachTagList: View {
    @EnvironmentObject var ModelData: ModelDataClass
    
    @State var tag: String
    
    /// 中英文切换变量
    @State var showEnglishOnly: Bool=false
    @State var showChineseOnly: Bool=false
    @State var showLanguage: String="hide_native_language"
    /// `SortMode`包含四个case
    @State var sortMode: SortMode = .byNameDown
    
    @State var isEditMode: EditMode = .inactive
    @State var selectWordsID: Set<UUID>=[]
    
    /// About the random words
    @State var isRandom: Bool=false
    @State var randomWords: [singleWord]=[]
    
    @State var SelectAllButtonText: String="select_all"
    
    var body: some View {
        VStack {
            List(selection: $selectWordsID) {
                ForEach(isRandom ? randomWords : sortWords(sortMode: sortMode, data: filteredWords(data: ModelData.word, tag: tag))) {
                    word in
                    ZStack(alignment: .leading) {
                        if ModelData.settings.showDetailDefinition {
                            ListRow(isShowEnglish: $showEnglishOnly, isShowChinese: $showChineseOnly, word: word)
                                /// `swipeActions` only available in `iOS 15.0, macOS 12.0` or later.
                                /// To support `iOS 14.0` and ealier, use https://github.com/SwipeCellKit/SwipeCellKit
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        ModelData.word.removeAll(where: { word.id == $0.id })
                                        saveData(data: ModelData.word)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        } else {
                            ListRowOneLine(isShowEnglish: $showEnglishOnly, isShowChinese: $showChineseOnly, word: word)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        ModelData.word.removeAll(where: { word.id == $0.id })
                                        saveData(data: ModelData.word)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }

                        NavigationLink(destination: ListDetail(selectWordsID: $selectWordsID, word: word)) {
                            EmptyView()
                        }.opacity(0.0)
                    }
                }
            }
            .navigationBarTitle("\(tag)", displayMode: .inline)
            Divider()
            
            HStack {
                if isEditMode == .inactive {
                    ZStack {
                        HStack {
                            SortModePicker(sortMode: $sortMode)
                                .gridColumnAlignment(.leading)
                            Spacer()
                            // switch the show language mode
                            Button(action: {
                                // Action to perform when the button is tapped
                                switchShowMode(Language: &showLanguage, showChineseOnly: &showChineseOnly, showEnglishOnly: &showEnglishOnly)
                            }) {
                                Text(LocalizedStringKey(showLanguage))
                                    .padding(.trailing, 10)
                            }
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                // Action to perform when the button is tapped
                                if ModelData.settings.clickBottomToShuffle {
                                    randomWords=filteredWords(data: ModelData.word, tag: tag).shuffled()
                                    isRandom.toggle()
                                }
                            }) {
                                Text("word_count \(getFilteredWordsCount(data: ModelData.word, tag: tag))")
                                    .bold()
                                    .foregroundColor(Color.black)
                            }
                            Spacer()
                        }
                    }
                    /// The animation
                    .transition(.asymmetric(insertion: .backslide, removal: .slide))
                } else {
                    HStack {
                        Spacer()
                        NavigationLink {
                            SelectTagsForMutiWords(WordsID: selectWordsID)
                        }
                        label: {
                            Text("select_tags")
                        }
                        /// This will be disabled when there is not words selected.
                        .disabled(selectWordsID.count == 0)
                        Spacer()
                        Button("delete") {
                            for id in selectWordsID {
                                ModelData.word.removeAll(where: { $0.id == id })
                            }
                            saveData(data: ModelData.word)
                        }
                        /// This will be disabled when there is not words selected.
                        .disabled(selectWordsID.count == 0)
                        Spacer()
                        Button(LocalizedStringKey(SelectAllButtonText)) {
                            if SelectAllButtonText == "select_all" {
                                selectWordsID=Set(filteredWords(data: ModelData.word, tag: tag).map { $0.id })
                                SelectAllButtonText="cancel"
                            } else {
                                selectWordsID=[]
                                SelectAllButtonText="select_all"
                            }
                        }
                        Spacer()
                    }
                    /// If you don't set `offset`, the whole bar will shift about 7 pixels up.
                    /// But it may not look very well on iPad. I will test it later.
                    .offset(x: 0, y: 7)
                    .transition(.asymmetric(insertion: .slide, removal: .backslide))
                }
            }
            /// make the `HStack` look better.
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 5,
                maxHeight: 30,
                alignment: .topLeading
            )
            .animation(.default, value: isEditMode)
            Divider()
        }
        .toolbar {
            /// 编辑按钮
            ToolbarItem(placement: .navigationBarTrailing) {
                ZStack {
                    Text(isEditMode.isEditing ? "done" : "edit")
                        .foregroundColor(Color.red)
                        .frame(width: 50, alignment: .trailing)
                        .padding(.trailing, 10)
                    EditButton()
                        .accentColor(.clear)
                }
            }
        }
        .environment(\.editMode, $isEditMode)
    }
}

struct EachTagList_Previews: PreviewProvider {
    static var previews: some View {
        EachTagList(tag: "作文")
    }
}
