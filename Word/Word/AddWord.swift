//
//  AddWord.swift
//  Word
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

struct AddWord: View {
    @EnvironmentObject var ModelData:ModelDataClass
    ///`Binding`变量,用于判断是否应该弹出输入表单
    @State var showNewWordForm:Bool=false

    var body: some View {
        Button {
            self.showNewWordForm.toggle()
        }label: {
            Label("Add new word",systemImage: "plus.square")
                .labelStyle(.iconOnly)
        }
        ///模态弹窗(ModalView)
        .sheet(isPresented: $showNewWordForm) {
            NewWordForm(showNewWordForm: $showNewWordForm)
        }
    }
}

struct NewWordForm: View {
    @EnvironmentObject var ModelData:ModelDataClass
    @State var wordName:String = ""
    @State var wordDefinition:String = ""
    @Binding var showNewWordForm:Bool

    var body: some View{
        NavigationView{
            VStack {
                Text("添加单词")
                    .font(.title2)
                Divider()
                TextField("单词/词组", text: $wordName)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Divider()
                TextEditor(text: $wordDefinition)
                    .padding()
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("完成"){
                        let time = getCurrentTime(timeFormat: .YYYYMMDDHHMMSS)
                        let newWord = singleWord(name: "\(wordName)", definition: "\(wordDefinition)",date: time,tag: [])
                        ModelData.word.append(newWord)
                        self.showNewWordForm.toggle()
                        ///将单词写入本地文件
                        saveData(data: ModelData.word)
                    }
                }
                ToolbarItem(placement: .navigation){
                    Button("取消"){
                        self.showNewWordForm.toggle()
                    }
                }
            }
        }
    }
}

struct AddWord_Previews: PreviewProvider {
    static var previews: some View {
        AddWord()
    }
}
