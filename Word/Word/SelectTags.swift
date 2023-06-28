//
//  SelectTag.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import SwiftUI

struct SelectTags: View {
    @EnvironmentObject var ModelData:ModelDataClass
    @State var word:singleWord
    
    @State var isShowActionSheet:Bool=false
    
    @State var selectedTags: [String]
    
    var body: some View {
        List{
            ForEach(getTags(data: ModelData.word),id: \.self){
                tag in
                Toggle(tag, isOn: bindingForTag(tag))
                    .toggleStyle(.button)
            }
        }
    }
    private func bindingForTag(_ tag: String) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                selectedTags.contains(tag)
            },
            set: { isSelected in
                if (isSelected) {
                    selectedTags.append(tag)
                } else {
                    selectedTags.removeAll { $0 == tag }
                }
                addTagsForWord()
            }
        )
    }
    private func addTagsForWord(){
        ///copy
        word.tag=selectedTags.map{$0}
        
        ModelData.word.removeAll(where: {$0.id==word.id})
        ModelData.word.append(word)
        saveData(data: ModelData.word)
    }
}

//struct SelectTags_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectTags()
//    }
//}
