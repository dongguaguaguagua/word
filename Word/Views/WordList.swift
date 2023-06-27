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
    @State var sortMode:SortMode = .byDateDown
    
    ///过滤用标签
    @State var filterTag:String = "全部"
    
    var body: some View {
        NavigationView{
            VStack {
                List() {
                    ForEach(sortWords(sortMode: sortMode, data: filteredWords(data: ModelData.word, tag: filterTag))){
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
                .navigationTitle("生词本")
                HStack {
                    Text("共计 \(getFilteredWordsCount(data:ModelData.word,tag:filterTag)) ")
                        .bold()
                    AddWord()
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
                ///排序菜单
                ToolbarItem(placement: .primaryAction) {
                    Picker("sort", selection: $sortMode) {
                        Text("从旧到新").tag(SortMode.byDateUp)
                        Text("从新到旧").tag(SortMode.byDateDown)
                        Text("从A到Z").tag(SortMode.byNameUp)
                        Text("从Z到A").tag(SortMode.byNameDown)
                        Text("随机打乱").tag(SortMode.random)
                    }
                }
                ///标签过滤器
                ToolbarItem(placement: .navigation) {
                    Picker("filter", selection: $filterTag) {
                        Text("全部").tag("全部")
                        ForEach(getTags(data: ModelData.word),id: \.self){
                            tag in
                            Text(tag)
                        }
                    }
                }
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
}


struct List_Previews: PreviewProvider {
    static let modelData=ModelDataClass()
    static var previews: some View {
        WordList()
            .environmentObject(modelData)
    }
}
