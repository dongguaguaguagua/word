//
//  AddWord.swift
//  Word
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI
import HighlightedTextEditor

struct AddWord: View {
    @EnvironmentObject var ModelData: ModelDataClass
    /// used to decide whether the new word form should be presented.
    @State var showNewWordForm: Bool = false

    var body: some View {
        Button {
            self.showNewWordForm.toggle()
        } label: {
            Label("Add new word", systemImage: "plus.square")
                .labelStyle(.iconOnly)
                .font(.title)
        }
        /// 模态弹窗(ModalView)
        .sheet(isPresented: $showNewWordForm) {
            NewWordForm(showNewWordForm: $showNewWordForm)
        }
    }
}

struct NewWordForm: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @State var wordName: String = ""
    @State var wordDefinition: String = ""
    @Binding var showNewWordForm: Bool
    @State var selectedTags: [String] = []
    @State var selectedTagsText: String = "select_tags"
    var body: some View {
        NavigationView {
            VStack {
                Text("add_word")
                    .font(.title2)
                Divider()
                TextField("word_placeholder", text: $wordName)
                    .disableAutocorrection(ModelData.settings.disableAutoCorrection)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Divider()
                HighlightedTextEditor(text: $wordDefinition,highlightRules: .markdown)
                    .padding()
                Divider()
                /// Select tags
                NavigationLink {
                    List {
                        ForEach(ModelData.tag, id: \.self) {
                            tag in
                            /// Tag color in small circles
                            HStack {
                                Circle()
                                    .fixedSize()
                                    .foregroundColor(Color(hex: tag.color))
                                Toggle(tag.name, isOn: bindingForTag(tag: tag.name))
                                    .toggleStyle(.button)
                            }
                            /// drag action
                            .onDrag {
                                let provider = NSItemProvider(object: NSString(string: tag.name))
                                return provider
                            }
                        }
                        .onMove { fromSet, to in
                            ModelData.tag.move(fromOffsets: fromSet, toOffset: to)
                            saveTags(data: ModelData.tag)
                        }
                    }.toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            AddTag(newTag: "")
                        }
                    }
                }
                /// It shows which tag user select. If there are no tags, it shows "选择标签".
                label: {
                    Text("\(selectedTagsText)")
                    ForEach(selectedTags, id: \.self) {
                        selectedTag in
                        Text("\(selectedTag)")
                            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                            .background(Color(hex: fromTagNameGetColor(data: ModelData.tag, Tag: selectedTag)))
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                .padding()
                Divider()
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("done") {
                        let time = getCurrentTime(timeFormat: .YYYYMMDDHHMMSS)
                        let newWord = singleWord(name: "\(wordName)", definition: "\(wordDefinition)", date: time, tag: selectedTags)
                        ModelData.word.append(newWord)
                        self.showNewWordForm.toggle()
                        /// 将单词写入本地文件
                        saveData(data: ModelData.word)
                    }
                }
                ToolbarItem(placement: .navigation) {
                    Button("cancel") {
                        self.showNewWordForm.toggle()
                    }
                }
            }
        }
    }

    private func bindingForTag(tag: String) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                selectedTags.contains(tag)
            },
            set: { isSelected in
                if isSelected {
                    selectedTags.append(tag)
                } else {
                    selectedTags.removeAll { $0 == tag }
                }
                if selectedTags == [] {
                    selectedTagsText = "select_tags"
                } else {
                    selectedTagsText = ""
                }
            }
        )
    }
}

// struct AddWord_Previews: PreviewProvider {
//    static var previews: some View {
//        AddWord()
//    }
// }
