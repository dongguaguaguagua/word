//
//  AddTag.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import SwiftUI

struct AddTag: View {
    
    var body: some View {
        Button(){
//            addTagMessage()
        }label: {
            Label("Add",systemImage: "plus")
        }
    }
//    func addTagMessage() {
//        let message = UIAlertController(title: "添加标签", message: "", preferredStyle: .alert)
//        message.addTextField { textField in
//            textField.placeholder = "Enter a new item"
//        }
//        message.addAction(UIAlertAction(title: "取消", style: .cancel))
//        message.addAction(UIAlertAction(title: "确定", style: .default) { _ in
//            if let newItem = message.textFields?.first?.text, !newItem.isEmpty {
//                var tagData:[singleTag]=loadTags()
//                tags.append(newItem)
//                tagData.append(singleTag(name: newItem, color: ""))
//                saveTags(tag: tagData)
//            }
//        })
//        UIApplication.shared.windows.first?.rootViewController?.present(message, animated: true)
//    }
}

//struct AddTag_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTag()
//    }
//}
