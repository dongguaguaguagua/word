//
//  BottomViews.swift
//  Word
//
//  Created by 胡宗禹 on 7/4/23.
//

import SwiftUI

struct BottomViews: View {
    @EnvironmentObject var ModelData:ModelDataClass
    
    @Binding var sortMode:SortMode
    @State var filterTag:String
    @Binding var isEditMode: EditMode
    
    @State var showLanguage:String="隐藏中文"
    @Binding var showEnglishOnly:Bool
    @Binding var showChineseOnly:Bool
    
    @Binding var selectWordsID:Set<UUID>
    
    @State var SelectAllButtonText:String = "全选"
    var body: some View {
        HStack() {
            if(isEditMode == .inactive){
                Spacer()
                SortModePicker(sortMode: $sortMode)
                Spacer()
                Text("共计 \(getFilteredWordsCount(data:ModelData.word,tag:filterTag)) ")
                    .bold()
                Spacer()
                ///切换中英文显示模式
                Text("\(showLanguage)")
                    .onTapGesture {
                        switchShowMode(Language: &showLanguage, showChineseOnly: &showChineseOnly, showEnglishOnly: &showEnglishOnly)
                    }
                Spacer()
            }else{
                Spacer()
                NavigationLink{
                    SelectTagsForMutiWords(WordsID: selectWordsID)
                }
                label: {
                    Text("设置标签")
                        .font(.title3)
                }
                .disabled(selectWordsID.count == 0)
                Spacer()
                Button("删除"){
                    for id in selectWordsID{
                        ModelData.word.removeAll(where: {$0.id==id})
                    }
                    saveData(data: ModelData.word)
                }
                .font(.title3)
                .foregroundColor(Color.red)
                .disabled(selectWordsID.count == 0)
                Spacer()
                Button(SelectAllButtonText){
                    if(SelectAllButtonText=="全选"){
                        selectWordsID=Set(filteredWords(data: ModelData.word, tag: filterTag).map { $0.id })
                        SelectAllButtonText="取消"
                    }else{
                        selectWordsID=[]
                        SelectAllButtonText="全选"
                    }
                }
                .font(.title3)
                Spacer()
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 5,
            maxHeight: 30,
            alignment: .topLeading
        )
        Divider()
    }
}

//struct BottomViews_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomViews()
//    }
//}
