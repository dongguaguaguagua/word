//
//  List.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI
import Foundation

struct WordList: View {
    @EnvironmentObject var ModelData:ModelDataClass

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
    
    
    var body: some View {
        NavigationView{
            VStack {
                Picker("sort", selection: $sortMode) {
                    Text("从旧到新").tag(SortMode.byDateUp)
                    Text("从新到旧").tag(SortMode.byDateDown)
                    Text("从A到Z").tag(SortMode.byNameUp)
                    Text("从Z到A").tag(SortMode.byNameDown)
                    Text("随机打乱").tag(SortMode.random)
                }
                .pickerStyle(.segmented)
                List() {
                    ForEach(sortWords(by: sortMode)){
                        word in
                        NavigationLink(){
                            ListDetail(word: word)
                        }
                    label: {
                        ListRow(isShowEnglish: $showEnglishOnly,isShowChinese:$showChineseOnly,word: word)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    ModelData.word.removeAll(where: {word.id==$0.id})
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
                .navigationTitle("生词本")
                HStack {
                    ///添加单词界面
                    AddWord()
                    Text("共计 \(ModelData.word.count) ")
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
        }
    }
    ///滑动删除方法
    func deleteRow(at offsets: IndexSet) {
        ModelData.word.remove(atOffsets: offsets)
        print("删除行序号：\(offsets)")
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
    func sortWords(by sortMode: SortMode) -> [singleWord] {
        switch sortMode {
        case .byDateUp:
            return ModelData.word.sorted { $0.date < $1.date }
        case .byDateDown:
            return ModelData.word.sorted { $0.date > $1.date }
        case .byNameUp:
            return ModelData.word.sorted { $0.name < $1.name }
        case .byNameDown:
            return ModelData.word.sorted { $0.name > $1.name }
        case .random:
            var shuffled = ModelData.word
            for i in 0..<ModelData.word.count {
                let index = Int.random(in: i..<ModelData.word.count)
                if index != i {
                    shuffled.swapAt(i, index)
                }
            }
            return shuffled
        }
    }
}


struct List_Previews: PreviewProvider {
    static let modelData=ModelDataClass()
    static var previews: some View {
        WordList()
            .environmentObject(modelData)
    }
}
