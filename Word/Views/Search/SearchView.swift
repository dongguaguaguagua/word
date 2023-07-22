//
//  SearchView.swift
//  Word
//
//  Created by 胡宗禹 on 7/10/23.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @State var searchWord: String = ""
    @State var searchResult: [DictStruct] = []
    @State var showAddWordSheet = false
//    @State var isActive:Bool=true
    var body: some View {
        NavigationView {
            VStack {
                TextField("search", text: $searchWord)
                    .onChange(of: searchWord, perform: { value in
                        let word = regexWord(str: value)
                        searchResult = fetchData(word: word)
                        if searchResult.count==0, ModelData.settings.enableFuzzySearch {
                            searchResult = fuzzySearch(str: word, fuzziness: 0.5)
                        }
                    })
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.leading, 8)
                    )
                    .padding(.horizontal, 10)
                    .autocorrectionDisabled(ModelData.settings.disableAutoCorrection)
                    .textInputAutocapitalization(.never)
                if searchWord=="" {
                    List {
                        Section("history_records") {
                            /// from settings get recent words, and show lists.
                            ForEach(ModelData.settings.recentSearchWord.reversed(), id: \.self) { recentWord in
                                let word = fetchDataFromWordName(word: recentWord)
                                ZStack(alignment: .leading) {
                                    HStack {
                                        Text(word.name)
                                            .lineLimit(1)
                                        Spacer()
                                        Text(word.translation)
                                            .lineLimit(1)
                                            .foregroundColor(.gray)
                                    }
                                    NavigationLink(destination: DetailView(word: word)) {
                                        EmptyView()
                                    }.opacity(0.0)
                                }
                                /// delete recent words action
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        ModelData.settings.recentSearchWord.removeAll(where: { $0==recentWord })
                                        saveSettings(data: ModelData.settings)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                    }
                } else {
                    List {
                        ForEach(searchResult, id: \.self) { word in
                            /// No arrow on the right of navigation link
                            ZStack(alignment: .leading) {
                                HStack {
                                    fuzzyHighlightedText(str: word.name, searched: searchWord)
                                        .lineLimit(1)
                                    Spacer()
                                    Text(word.translation)
                                        .lineLimit(1)
                                        .foregroundColor(.gray)
                                }
                                NavigationLink(destination: DetailView(word: word)) {
                                    EmptyView()
                                }.opacity(0.0)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        // TODO: set default Tags
//                        Spacer()
                        Button {
                            self.showAddWordSheet = true
                        } label: {
                            Label("Add", systemImage: "plus")
                        }
                        .sheet(isPresented: $showAddWordSheet) {
                            NewWordForm(showNewWordForm: $showAddWordSheet)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
