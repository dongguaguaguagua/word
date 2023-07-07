//
//  ListDetail.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

///This is the detail view of each word.
///It will appear when user click the navigation link.
///It contains: The word's name, definition, create/edit date, tags with color.
///It also has edit button and tag-select button on the tool bar.
///
///Many works need to be done.
///- markdown support
///- each tag is a navigation link
///- two button, you can press them to show the next/previous word's detail
struct ListDetail: View {
    @EnvironmentObject var ModelData:ModelDataClass
    @Binding var selectWordsID:Set<UUID>
    ///receive a word
    var word:singleWord
    
    var body: some View {
        VStack {
            HStack(){
                ForEach(word.tag,id:\.self){tag in
                    ZStack{
                        ///The tags. Currently it is represented by `text` with round edge and colorful background.
                        Text("\(tag)")
                            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                            .background(Color(hex: fromTagNameGetColor(data: ModelData.tag, Tag: tag)))
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
            }
            Text(word.name)
                .font(.title)
            ///Actually, the `create time` is not accurate yet. When you edit a word, this will also be refreshed.
            ///So I consider creating another attribute `edit date`.(NOT IN PROGRESS)
            Text("添加时间:\(word.date)")
                .foregroundColor(.gray)
            Spacer()
                .frame(minHeight: 10,maxHeight: 20)
            Text(word.definition)
                .font(.title2)
            .navigationBarTitle(word.name, displayMode: .inline)
        }

        .toolbar {
            ///edit button
            ToolbarItem(placement: .primaryAction) {
                EditWord(wordId: word.id,wordName: word.name, wordDef: word.definition)
            }
            ///tag-select button
            ToolbarItem(placement: .primaryAction) {
                ///The `selectedTags` parameter  is so complex, why not use`word.tag`?
                ///Actually, it is designed to prevent such situation (If you use `word.tag`):
                ///in `manage` mode, you enter tag `A` and find words has tag `A`.
                ///So you deselect it, and back to the word's detail view.
                ///But the most wield thing is that even the `ModelData` shows that the word has no tag `A`,
                ///when you enter the tag-select view again, you will find the word has tag `A`.
                ///So the most robust way to prevent this is select tags directly in `ModelData`.
                NavigationLink{
                    SelectTags(word: word,selectedTags: ModelData.word.filter({$0.id==word.id}).count==1 ? ModelData.word.filter({$0.id==word.id})[0].tag : word.tag)
                }
                label: {
                    Label("Select", systemImage: (ModelData.word.filter({$0.id==word.id}).count==1 ? ModelData.word.filter({$0.id==word.id})[0].tag.count==0 : word.tag.count==0) ? "tag" : "tag.fill")
                }
            }
        }
        ///To fix the bug that you enter the word detail, then the word is selected.
        .onAppear{
            selectWordsID=[]
        }
    }
}
//
//struct ListDetail_Previews: PreviewProvider {
//    static var word=ModelDataClass().word
//    static var previews: some View {
//        ListDetail(selectWordsID: [],word: word[0])
//            .environmentObject(ModelDataClass())
//    }
//}
