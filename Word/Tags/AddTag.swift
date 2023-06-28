//
//  AddTag.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import SwiftUI

struct AddTag: View {
    @EnvironmentObject var ModelData:ModelDataClass
    var body: some View {
        Button(){
            addTagMessage()
        }label: {
            Label("Add",systemImage: "plus")
        }
    }
    func addTagMessage() {
        let message = UIAlertController(title: "添加标签", message: "", preferredStyle: .alert)
        message.addTextField { textField in
            textField.placeholder = "Enter a new item"
        }
        message.addAction(UIAlertAction(title: "取消", style: .cancel))
        message.addAction(UIAlertAction(title: "确定", style: .default) { _ in
            if let newTag = message.textFields?.first?.text, !newTag.isEmpty {
                let time = getCurrentTime(timeFormat: .YYYYMMDDHHMMSS)
                let newWord = singleWord(name: "__EMPTY_ITEM__", definition: "",date: time,isShow: false,tag: ["\(newTag)"])
                ModelData.word.append(newWord)
                ///将单词写入本地文件
                saveData(data: ModelData.word)
            }
        })
        UIApplication.shared.windows.first?.rootViewController?.present(message, animated: true)
    }
}

//struct AddTag_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTag()
//    }
//}
