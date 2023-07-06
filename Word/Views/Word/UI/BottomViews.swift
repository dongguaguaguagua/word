//
//  BottomViews.swift
//  Word
//
//  Created by 胡宗禹 on 7/4/23.
//

import SwiftUI

///Apple doesn't provide a back slide animation option
///So here is the replacement:
extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}

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
                HStack{
                    Spacer()
                    SortModePicker(sortMode: $sortMode)
                    Spacer()
                    Text("共计 \(getFilteredWordsCount(data:ModelData.word,tag:filterTag)) ")
                        .bold()
                    Spacer()
                    ///switch the show language mode
                    Text("\(showLanguage)")
                        .onTapGesture {
                            switchShowMode(Language: &showLanguage, showChineseOnly: &showChineseOnly, showEnglishOnly: &showEnglishOnly)
                        }
                    Spacer()
                }
                ///The animation
                .transition(.asymmetric(insertion: .backslide, removal: .slide))
            }else{
                HStack{
                    Spacer()
                    NavigationLink{
                        SelectTagsForMutiWords(WordsID: selectWordsID)
                    }
                    label: {
                        Text("设置标签...")
                    }
                    ///This will be disabled when there is not words selected.
                    .disabled(selectWordsID.count == 0)
                    Spacer()
                    Button("删除"){
                        for id in selectWordsID{
                            ModelData.word.removeAll(where: {$0.id==id})
                        }
                        saveData(data: ModelData.word)
                    }
                    ///This will be disabled when there is not words selected.
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
                    Spacer()
                }
                ///If you don't set `offset`, the whole bar will shift about 7 pixels up.
                ///But it may not look very well on iPad. I will test it later.
                .offset(x:0,y:7)
                .transition(.asymmetric(insertion: .slide, removal: .backslide))
            }
        }
        ///make the `HStack` look better.
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 5,
            maxHeight: 30,
            alignment: .topLeading
        )
        .animation(.default,value: isEditMode)
        Divider()
    }
}

//struct BottomViews_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomViews()
//    }
//}
