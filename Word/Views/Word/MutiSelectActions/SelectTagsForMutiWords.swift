//
//  SelectTagsForMutiWords.swift
//  Word
//
//  Created by 胡宗禹 on 7/2/23.
//

import SwiftUI

/// Actually, it is a clone of `SelectTags.swift` in `Actions`, with a few modifies
struct SelectTagsForMutiWords: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @State var WordsID: Set<UUID>
    @State var selectedTags: [String] = []

    var body: some View {
        List {
            ForEach(ModelData.tag, id: \.self) {
                tag in
                HStack {
                    Circle()
                        .fixedSize()
                        .foregroundColor(Color(hex: tag.color))
                    Toggle(tag.name, isOn: bindingForTag(tag: tag.name))
                        .toggleStyle(.button)
                }
                /// drag action
                .onDrag {
                    let provider = NSItemProvider(object: NSString(string: tag.name))
                    return provider
                }
            }
            .onMove { fromSet, to in
                ModelData.tag.move(fromOffsets: fromSet, toOffset: to)
                saveTags(data: ModelData.tag)
            }
        }.toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddTag(newTag: "")
            }
        }
        .onDisappear {
            addTagsForWord()
        }
    }

    private func bindingForTag(tag: String) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                selectedTags.contains(tag)
            },
            set: { isSelected in
                if isSelected {
                    selectedTags.append(tag)
                } else {
                    selectedTags.removeAll { $0 == tag }
                }
            }
        )
    }

    func addTagsForWord() {
        for index in 0 ..< ModelData.word.count {
            if WordsID.contains(ModelData.word[index].id) {
                /// copy
                ModelData.word[index].tag = selectedTags.map { $0 }
            }
        }
        saveData(data: ModelData.word)
    }
}

struct SelectTagsForMutiWords_Previews: PreviewProvider {
    static var previews: some View {
        SelectTagsForMutiWords(WordsID: [])
    }
}
