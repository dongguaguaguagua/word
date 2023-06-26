//
//  eachTagList.swift
//  Word
//
//  Created by 胡宗禹 on 6/26/23.
//

import SwiftUI

struct eachTagList: View {
    @EnvironmentObject var ModelData:ModelDataClass
    
    var tag:String
    
    ///中英文切换变量
    @State var showEnglishOnly:Bool=false
    @State var showChineseOnly:Bool=false
    @State var showLanguage:String="隐藏中文"
    ///`SortMode`包含四个case
    @State var sortMode:SortMode = .byNameDown
    enum SortMode: String, CaseIterable, Identifiable {
        case byDateUp, byDateDown, byNameUp, byNameDown, random
        var id: Self { self }
    }
    var fileredWords:[singleWord] {
        ModelData.word.filter({$0.tag==tag})
    }
    var body: some View {
        VStack {
            List() {
                ForEach(sortWords(sortMode: sortMode, data: fileredWords)){
                    word in
                    NavigationLink(){
                        ListDetail(word: word)
                    }
                    label: {
                    ListRow(isShowEnglish: $showEnglishOnly,isShowChinese:$showChineseOnly,word: word)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                ModelData.word.removeAll(where: {word.id==$0.id})
                                saveData(data: ModelData.word)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            HStack {
                Picker("sort", selection: $sortMode) {
                    Text("从旧到新").tag(SortMode.byDateUp)
                    Text("从新到旧").tag(SortMode.byDateDown)
                    Text("从A到Z").tag(SortMode.byNameUp)
                    Text("从Z到A").tag(SortMode.byNameDown)
                    Text("随机打乱").tag(SortMode.random)
                }
                Text("共计 \(fileredWords.count) ")
                    .bold()
                ///切换中英文显示模式
                Text("\(showLanguage)")
                    .padding()
                    .onTapGesture {
                        switchShowMode()
                    }
            }
            Divider()
        }
        .background(.ultraThinMaterial)
        .toolbar(){
            ToolbarItem(placement: .principal){
                Text(tag)
                    .bold()
            }
        }
    }

    ///判断显示方案和按钮文字
    func switchShowMode(){
        switch showLanguage{
        case "隐藏中文":
            showChineseOnly=false
            showEnglishOnly=true
            showLanguage="隐藏英文"
            break
        case "隐藏英文":
            showChineseOnly=true
            showEnglishOnly=false
            showLanguage="中文英文"
            break
        case "中文英文":
            showChineseOnly=false
            showEnglishOnly=false
            showLanguage="隐藏中文"
            break
        default:
            showChineseOnly=false
            showEnglishOnly=false
            showLanguage="隐藏中文"
            break
        }
    }
    ///接收`sortMode`作为参数,返回的是排序好的`ModelData`
    func sortWords(sortMode: SortMode,data: [singleWord]) -> [singleWord] {
        switch sortMode {
        case .byDateUp:
            return data.sorted { $0.date < $1.date }
        case .byDateDown:
            return data.sorted { $0.date > $1.date }
        case .byNameUp:
            return data.sorted { $0.name < $1.name }
        case .byNameDown:
            return data.sorted { $0.name > $1.name }
        case .random:
            return data.shuffled()
            
            ///it can be done like this:
            ///```
            ///var shuffled = data
            ///for i in 0..<data.count {
            ///    let index = Int.random(in: i..<data.count)
            ///    if index != i {
            ///        shuffled.swapAt(i, index)
            ///    }
            ///}
            ///return shuffled
            ///```
        }
    }
}

//struct eachTagList_Previews: PreviewProvider {
//    static var previews: some View {
//        eachTagList("无标签")
//    }
//}
