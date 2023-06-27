//
//  manage.swift
//  Word
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

struct Manage: View {
    @EnvironmentObject var ModelData:ModelDataClass
    
    var body: some View {
        NavigationView{
            List{
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
                    }
                }
            }
            .navigationTitle("标签")
        }
    }
}

struct deleteButton:View{
    @EnvironmentObject var ModelData:ModelDataClass
    
    var tag:String
    var body: some View{
        ///删除标签
        Button(role: .destructive) {
            if(tag=="无标签"){
                deleteNoTagsAlert()
            }else{
                for i in 0..<ModelData.word.count{
                    ModelData.word[i].tag.removeAll(where: {$0==tag})
                }
                saveData(data: ModelData.word)
            }
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
    func deleteNoTagsAlert() {
        let alert = UIAlertController(title: "不能删除无标签哦", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
}

struct Manage_Previews: PreviewProvider {
    static var previews: some View {
        Manage()
    }
}
