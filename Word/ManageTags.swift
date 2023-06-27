//
//  manage.swift
//  Word
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

struct Manage: View {
    @EnvironmentObject var ModelData:ModelDataClass
    @State var isShowDeleteWarn:Bool=false
    
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
                    .alert("无法删除", isPresented: $isShowDeleteWarn){
                        ///todo:删的时候有点bug
                    }
                    .swipeActions(edge: .trailing) {
                        deleteButton(isShowDeleteWarn: $isShowDeleteWarn,tag: tag)
                    }
                }
            }
            .navigationTitle("标签")
        }
    }
}

struct deleteButton:View{
    @EnvironmentObject var ModelData:ModelDataClass
    ///用于防止删除“无标签”
    @Binding var isShowDeleteWarn:Bool
    var tag:String
    var body: some View{
        ///删除标签
        Button(role: .destructive) {
            if(tag=="无标签"){
                isShowDeleteWarn=true
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
}

struct Manage_Previews: PreviewProvider {
    static var previews: some View {
        Manage()
    }
}
