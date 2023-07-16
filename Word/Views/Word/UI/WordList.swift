//
//  List.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import Foundation
import SwiftUI

/// The page of `word` tab.
struct WordList: View {
    @EnvironmentObject var ModelData: ModelDataClass

    /// The varables record whether to show English or Chinese.
    @State var showEnglishOnly: Bool=false
    @State var showChineseOnly: Bool=false
    @State var showLanguage: String="hide_native_language"

    /// `SortMode` has four cases, and default is `byDateDown`
    @State var sortMode: SortMode = .byDateDown

    /// Tag to filter, and default is `All`
    @State var filterTag: String="all_words"

    @State var isEditMode: EditMode = .inactive

    /// A set that contains the selected word's UUID
    @State var selectWordsID: Set<UUID>=[]

    /// About the random words
    @State var isRandom: Bool=false
    @State var randomWords: [singleWord]=[]

    @State var SelectAllButtonText: String="select_all"

    var body: some View {
        NavigationView {
            /// Plan to use `lazyStack` instead
            VStack {
                List(selection: $selectWordsID) {
                    ForEach(isRandom ? randomWords : sortWords(sortMode: sortMode, data: filteredWords(data: ModelData.word, tag: filterTag))) {
                        word in
                        /// ```swift
                        /// ZStack(){
                        ///    CustomView()
                        ///    NavigationLink(destination: ListDetail(word: word)){
                        ///         EmptyView()
                        ///    }.opacity(0.0)
                        /// }
                        /// ```
                        /// Use this way to hide arrows in every navigation link.
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
                .navigationTitle("word_book_title")
                Divider()

                /// The bottom view.
//                Text(isRandom ? "拨乱反正" : "随机打乱")
//                    .onTapGesture {
//                        randomWords=filteredWords(data: ModelData.word, tag: filterTag).shuffled()
//                        isRandom.toggle()
//                    }
                HStack {
                    if isEditMode == .inactive {
                        ZStack {
                            HStack {
                                SortModePicker(sortMode: $sortMode)
                                    .gridColumnAlignment(.leading)
                                Spacer()
                                /// switch the show language mode
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
                                        randomWords=filteredWords(data: ModelData.word, tag: filterTag).shuffled()
                                        isRandom.toggle()
                                    }
                                }) {
                                    Text("word_count \(getFilteredWordsCount(data: ModelData.word, tag: filterTag))")
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
                                    selectWordsID=Set(filteredWords(data: ModelData.word, tag: filterTag).map { $0.id })
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
                /// Apple provide `EditButton()` to switch edit mode.
                /// But unfortunately, this Button is currently **not customizable**
                /// You have no way to change the button's text or something.
                /// You can also use your own edit button:
                /// ```swift
                /// Button(isEditMode.isEditing ? "完成": "编辑") {
                /// switch isEditMode {
                ///    case .active:
                ///         self.isEditMode = .inactive
                ///    case .inactive:
                ///         self.isEditMode = .active
                ///    default:
                ///         break
                ///    }
                /// }
                /// ```
                /// But the button has no animation. It is not what I want.
                /// So I have no way but let `text` overlap with `EditButton()`.
                ToolbarItem(placement: .navigationBarLeading) {
                    ZStack {
                        Text(isEditMode.isEditing ? "done" : "edit")
                            .foregroundColor(Color.blue)
                        EditButton()
                            .accentColor(.clear)
                    }
                }
                /// Tag picker
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker("filter", selection: $filterTag) {
                        Text("all_words").tag("all_words")
                        Text("no_tag").tag("no_tag")
                        ForEach(ModelData.tag.map { $0.name }, id: \.self) {
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
