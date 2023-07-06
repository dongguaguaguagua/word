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
    
    @State var selectedTags: [String]
    
    var body: some View {
        List{
            ForEach(ModelData.tag ,id: \.self){
                tag in
                HStack{
                    Circle()
                        .fixedSize()
                        .foregroundColor(Color(hex: tag.color))
                    Toggle(tag.name, isOn: bindingForTag(tag: tag.name))
                        .toggleStyle(.button)
                }
                ///drag action
                .onDrag {
                    let provider = NSItemProvider.init(object: NSString(string: tag.name))
                    return provider
                }
            }
            .onMove { fromSet, to in
                ModelData.tag.move(fromOffsets: fromSet, toOffset: to)
                saveTags(data: ModelData.tag)
            }
        }.toolbar(){
            ToolbarItem(placement: .primaryAction){
                AddTag(newTag: "")
            }
        }
        .onDisappear{
            addTagsForWord()
        }
    }
    private func bindingForTag(tag: String) -> Binding<Bool> {
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
            }
        )
    }
    func addTagsForWord(){
        for index in 0..<ModelData.word.count{
            if(ModelData.word[index].id==word.id){
                ///copy data
                ModelData.word[index].tag=selectedTags.map{$0}
            }
        }
        saveData(data: ModelData.word)
    }
}

//struct SelectTags_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectTags()
//    }
//}
