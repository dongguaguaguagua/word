//
//  ListDetail.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

struct ListDetail: View {
    @EnvironmentObject var ModelData:ModelDataClass
    var word:singleWord
    var body: some View {
        VStack {
            Text(word.name)
                .font(.title)
            Text("添加时间:\(word.date)")
                .foregroundColor(.gray)
            Spacer()
                .frame(minHeight: 10,maxHeight: 20)
            Text(word.definition)
                .font(.title2)
            .navigationBarTitle(word.name, displayMode: .inline)
        }

        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                EditWord(wordId: word.id,wordName: word.name, wordDef: word.definition)
            }
            ToolbarItem(placement: .primaryAction) {
                ///`selectedTags`参数写的那么复杂是为了防止以下情况：
                ///manage模式下，在某个标签中将单词的这个标签删除了,
                ///返回以后单词还存在于原有标签中，
                ///将导致再次进入`NavigationLink`时会带有原来的标签
                NavigationLink{
                    SelectTags(word: word,selectedTags: ModelData.word.contains(word) ? ModelData.word.filter({$0.id==word.id})[0].tag : word.tag)
                }
                label: {
                    Label("Select", systemImage: (ModelData.word.contains(word) ? ModelData.word.filter({$0.id==word.id})[0].tag.count==0 : word.tag.count==0) ? "tag" : "tag.fill")
                }
            }
        }
    }
}

struct ListDetail_Previews: PreviewProvider {
    static var word=ModelDataClass().word
    static var previews: some View {
        ListDetail(word: word[0])
            .environmentObject(ModelDataClass())
    }
}
