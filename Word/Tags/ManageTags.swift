//
//  manage.swift
//  Word
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

struct Manage: View {
    @EnvironmentObject var ModelData:ModelDataClass
    @State var isShowEditField:Bool=false
    @State var tagName:String=""
    
    var noTagWord:[singleWord]{
        ModelData.word.filter({$0.tag==[]})
    }
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink(){
                    NoTagList()
                }label: {
                    Text("无标签")
                    Text("\(noTagWord.count)")
                        .bold()
                        .foregroundColor(.pink)
                }
                
                ForEach(getTags(data: ModelData.word),id: \.self){tag in
                    NavigationLink(){
                        EachTagList(tag: tag)
                    }label: {
                        Text(tag)
                        Text("\(getFilteredWordsCount(data:ModelData.word,tag:tag))")
                            .bold()
                            .foregroundColor(.pink)
                    }
                    .swipeActions(edge: .trailing) {
                        deleteButton(tag: tag)
                        Button(){
                            renameTagMessage(tagName: tag)
                        }label: {
                            Label("Rename",systemImage: "character.cursor.ibeam")
                        }
                        .tint(.blue)
                    }
                }
            }
            .navigationTitle("标签")
            .toolbar(){
                ToolbarItem(placement: .primaryAction){
                    AddTag()
                }
            }
        }
    }
    
    func renameTagMessage(tagName:String) {
        let message = UIAlertController(title: "重命名标签", message: "", preferredStyle: .alert)
        message.addTextField { textField in
            textField.placeholder = "Enter a new item"
            textField.text="\(tagName)"
        }
        message.addAction(UIAlertAction(title: "取消", style: .cancel))
        message.addAction(UIAlertAction(title: "重命名", style: .default) { _ in
            if let newItem = message.textFields?.first?.text, !newItem.isEmpty {
                for i in 0..<ModelData.word.count{
                    if(ModelData.word[i].tag.contains(tagName)){
                        ModelData.word[i].tag.removeAll(where: {$0==tagName})
                        ModelData.word[i].tag.append(newItem)
                    }
                }
                saveData(data: ModelData.word)
            }
        })
        UIApplication.shared.windows.first?.rootViewController?.present(message, animated: true)
    }
}

struct deleteButton:View{
    @EnvironmentObject var ModelData:ModelDataClass
    
    var tag:String
    var body: some View{
        ///删除标签
        Button(role: .destructive) {
            for i in 0..<ModelData.word.count{
                ModelData.word[i].tag.removeAll(where: {$0==tag})
            }
            saveData(data: ModelData.word)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}

struct Manage_Previews: PreviewProvider {
    static var previews: some View {
        Manage()
    }
}
