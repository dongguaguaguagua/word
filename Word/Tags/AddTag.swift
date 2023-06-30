//
//  AddTag.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import SwiftUI

//struct FileDetails: Identifiable {
//    var id: String { name }
//    let name: String
//    let fileType: UTType
//}

struct AddTag: View {
    @EnvironmentObject var ModelData:ModelDataClass
    @State var newTag:String = ""
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
            textField.placeholder = "标签名称"
        }
        message.addAction(UIAlertAction(title: "取消", style: .cancel))
        message.addAction(UIAlertAction(title: "确定", style: .default) { _ in
            if let newTag = message.textFields?.first?.text, !newTag.isEmpty {
                if let index = ModelData.word.firstIndex(where: {$0.name=="__TAG_ITEM__"}) {
                    ModelData.word[index].tag.append(newTag)
                    saveData(data: ModelData.word)
                }
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
