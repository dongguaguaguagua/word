//
//  ListDetail.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import MarkdownUI
import SwiftUI

/// This is the detail view of each word.
/// It will appear when user click the navigation link.
/// It contains: The word's name, definition, create/edit date, tags with color.
/// It also has edit button and tag-select button on the tool bar.
///
/// Many works need to be done.
/// - two button, you can press them to show the next/previous word's detail
struct ListDetail: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @Binding var selectWordsID: Set<UUID>
    @State var isShowWordSheet:Bool=false
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    /// receive a word
    var word: singleWord
    
    var body: some View {
        VStack(alignment: .leading) {
            let DictWord = fetchDataFromWordName(word: word.name)
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        ForEach(word.tag, id: \.self) { tag in
                            /// Each tag is a navigation link
                            NavigationLink {
                                EachTagList(tag: tag)
                            }
                            label: {
                                /// The tags. Currently, it is represented by `text` with round edge and colorful background.
                                Text("\(tag)")
                                    .font(.system(size: 10, weight: .bold, design: .default))
                                    .padding(EdgeInsets(top: 5, leading: 7, bottom: 5, trailing: 7))
                                    .background(Color(hex: fromTagNameGetColor(data: ModelData.tag, Tag: tag)))
                                    .foregroundColor(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        }
                    }
                    HStack {
                        Text(word.name)
                            .font(.title)
                        if DictWord.phonetic != "" {
                            Text("| "+DictWord.phonetic+" |")
                                .font(.system(size: 15))
                                .padding(.leading, 10)
                        }
                        Spacer()
                    }.padding(.bottom, 5)
                    /// Actually, the `create time` is not accurate yet. When you edit a word, this will also be refreshed.
                    /// So I consider creating another attribute `edit date`.(NOT IN PROGRESS)
                    HStack {
                        Label("Add time", systemImage: "clock")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.gray)
                        Text(word.date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }.padding(.leading, 20)
                HStack {
                    Spacer()
                    RecordedSealView(dateText: word.date)
                        .padding(.trailing, 20)
                }
            }
            List {
                if word.definition != "" {
                    Section(header: Text("My definition")) {
                        if ModelData.settings.enableMarkdown {
                            Markdown(word.definition)
                                .markdownTheme(.gitHub)
                        } else {
                            Text(word.definition)
                        }
                    }
                }
                ImportanceRank(DictWord: DictWord)
                ChineseTranslations(DictWord: DictWord)
                EnglishDefinition(DictWord: DictWord)
                WordExchanges(isShowWordSheet: false, DictWord: DictWord)
            }
            .padding([.leading, .trailing, .top, .bottom], 0)
            .navigationBarTitle(word.name, displayMode: .inline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(hex: "#f2f2f7"))

        .toolbar {
            /// edit button
            ToolbarItem(placement: .primaryAction) {
                EditWord(wordId: word.id, wordName: word.name, wordDef: word.definition)
            }
            /// tag-select button
            ToolbarItem(placement: .primaryAction) {
                /// The `selectedTags` parameter  is so complex, why not use`word.tag`?
                /// Actually, it is designed to prevent such situation (If you use `word.tag`):
                /// in `manage` mode, you enter tag `A` and find words has tag `A`.
                /// So you deselect it, and back to the word's detail view.
                /// But the most wield thing is that even the `ModelData` shows that the word has no tag `A`,
                /// when you enter the tag-select view again, you will find the word has tag `A`.
                /// So the most robust way to prevent this is select tags directly in `ModelData`.
                NavigationLink {
                    SelectTags(word: word, selectedTags: ModelData.word.filter { $0.id==word.id }.count==1 ? ModelData.word.filter { $0.id==word.id }[0].tag : word.tag)
                }
                label: {
                    Label("Select", systemImage: (ModelData.word.filter { $0.id==word.id }.count==1 ? ModelData.word.filter { $0.id==word.id }[0].tag.count==0 : word.tag.count==0) ? "tag" : "tag.fill")
                }
            }
        }
        /// To fix the bug that you enter the word detail, then the word is selected.
        .onAppear {
            selectWordsID = []
        }
    }
}

// struct ListDetail_Previews: PreviewProvider {
//    static var word=ModelDataClass().word
//    static var previews: some View {
//        ListDetail(selectWordsID: [],word: word[0])
//            .environmentObject(ModelDataClass())
//    }
// }
