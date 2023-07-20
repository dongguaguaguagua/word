//
//  EditWord.swift
//  Word
//
//  Created by 胡宗禹 on 6/26/23.
//

import HighlightedTextEditor
import SwiftUI

struct EditWord: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @State var showEditWordForm: Bool = false
    @State var wordId: UUID
    @State var wordName: String
    @State var wordDef: String

    var body: some View {
        Button {
            self.showEditWordForm.toggle()
        } label: {
            Label("Edit", systemImage: "square.and.pencil")
                .labelStyle(.iconOnly)
        }
        /// 模态弹窗(ModalView)
        .sheet(isPresented: $showEditWordForm) {
            /// Use `id` to insert edited word. Use `wordName` and `wordDef` to be a placeholder.
            EditWordForm(wordId: $wordId, wordName: $wordName, wordDef: $wordDef, showEditWordForm: $showEditWordForm)
        }
    }
}

struct EditWordView: View {
    @EnvironmentObject var ModelData: ModelDataClass

    @Binding var wordName: String
    @Binding var wordDefinition: String
    var body: some View {
        VStack {
            TextField("word_placeholder", text: $wordName)
                .disableAutocorrection(ModelData.settings.disableAutoCorrection)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .textInputAutocapitalization(.never)
            Divider()
            if ModelData.settings.enableMarkdown {
                HighlightedTextEditor(text: $wordDefinition, highlightRules: .markdown)
                    .padding()
            } else {
                TextEditor(text: $wordDefinition)
//                TextFieldExample()
            }
        }
        .toolbar {
            ToolbarItemGroup {
                HStack {}
            }
        }
    }
}

struct EditWordForm: View {
    @EnvironmentObject var ModelData: ModelDataClass

    @Binding var wordId: UUID
    @Binding var wordName: String
    @Binding var wordDef: String
    @Binding var showEditWordForm: Bool

    var body: some View {
        NavigationView {
            EditWordView(wordName: $wordName, wordDefinition: $wordDef)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("done") {
                            /// A new word is created. After deleting the old word, insert the new word into `ModelData`
//                        ModelData.word.removeAll(where: { wordId == $0.id })
                            let time = getCurrentTime(timeFormat: .YYYYMMDDHHMMSS)
                            let index = ModelData.word.firstIndex(where: { $0.id == wordId }) ?? 0

                            ModelData.word[index].name = wordName
                            ModelData.word[index].definition = wordDef
                            ModelData.word[index].date = time
                            self.showEditWordForm.toggle()
                            saveData(data: ModelData.word)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("cancel") {
                            self.showEditWordForm.toggle()
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("edit_word")
                            .font(.headline)
                    }
                }
        }
    }
}

// struct EditWord_Previews: PreviewProvider {
//    static var previews: some View {
//        EditWord()
//    }
// }
