//
//  EditWord.swift
//  Word
//
//  Created by 胡宗禹 on 6/26/23.
//

import SwiftUI

struct EditWord: View {
    @EnvironmentObject var ModelData:ModelDataClass
    @State var showEditWordForm:Bool=false
    @State var wordId:UUID
    @State var wordName:String
    @State var wordDef:String
    
    var body: some View {
        Button {
            self.showEditWordForm.toggle()
        }label: {
            Label("Edit",systemImage: "square.and.pencil")
                .labelStyle(.iconOnly)
        }
        ///模态弹窗(ModalView)
        .sheet(isPresented: $showEditWordForm) {
            ///Use `id` to insert edited word. Use `wordName` and `wordDef` to be a placeholder.
            EditWordForm(wordId:$wordId, wordName: $wordName, wordDef: $wordDef, showEditWordForm: $showEditWordForm)
        }
    }
}

struct EditWordForm: View {
    @EnvironmentObject var ModelData:ModelDataClass
    
    @Binding var wordId:UUID
    @Binding var wordName:String
    @Binding var wordDef:String
    @Binding var showEditWordForm:Bool
    
    var body: some View{
        NavigationView{
            VStack {
                Text("edit_word")
                    .font(.title2)
                Divider()
                TextField("word_placeholder", text: $wordName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(ModelData.settings.disableAutoCorrection)
                    .padding()
                Divider()
                TextEditor(text: $wordDef)
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("done"){
                        ///A new word is created. After deleting the old word, insert the new word into `ModelData`
                        ModelData.word.removeAll(where: {wordId==$0.id})
                        let time = getCurrentTime(timeFormat: .YYYYMMDDHHMMSS)
                        let newWord = singleWord(id: wordId, name: "\(wordName)", definition: "\(wordDef)",date: time,tag: [""])
                        ModelData.word.append(newWord)
                        self.showEditWordForm.toggle()
                        saveData(data: ModelData.word)
                    }
                }
                ToolbarItem(placement: .navigation){
                    Button("cancel"){
                        self.showEditWordForm.toggle()
                    }
                }
            }
        }
    }
}
//struct EditWord_Previews: PreviewProvider {
//    static var previews: some View {
//        EditWord()
//    }
//}
