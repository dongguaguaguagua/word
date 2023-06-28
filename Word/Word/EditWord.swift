//
//  EditWord.swift
//  Word
//
//  Created by 胡宗禹 on 6/26/23.
//

import SwiftUI

struct EditWord: View {
    @EnvironmentObject var ModelData:ModelDataClass
    ///`Binding`变量,用于判断是否应该弹出输入表单
    @State var showEditWordForm:Bool=false
    @State var wordId:UUID
    @State var wordName:String
    @State var wordDef:String
    
    var body: some View {
        Button {
            self.showEditWordForm.toggle()
            print(showEditWordForm)
        }label: {
            Label("Edit",systemImage: "square.and.pencil")
                .labelStyle(.iconOnly)
        }
        ///模态弹窗(ModalView)
        .sheet(isPresented: $showEditWordForm) {
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
                Text("编辑单词")
                    .font(.title2)
                Divider()
                TextField("单词/词组", text: $wordName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .padding()
                Divider()
                TextEditor(text: $wordDef)
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("完成"){
                        ModelData.word.removeAll(where: {wordId==$0.id})
                        let time = getCurrentTime(timeFormat: .YYYYMMDDHHMMSS)
//                        let newWord = singleWord(id: wordId, name: "\(wordName)", definition: "\(wordDef)",date: time,tag: [singleWord.tagStruct(name: "\(newTag)", color: "#88c0b4")])
                        let newWord = singleWord(id: wordId, name: "\(wordName)", definition: "\(wordDef)",date: time,tag: [""])
                        ModelData.word.append(newWord)
                        self.showEditWordForm.toggle()
                        ///将单词写入本地文件
                        saveData(data: ModelData.word)
                    }
                }
                ToolbarItem(placement: .navigation){
                    Button("取消"){
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
