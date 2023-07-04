//
//  ListRow.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

struct ListRow: View {
    @EnvironmentObject var ModelData:ModelDataClass
    @Binding var isShowEnglish:Bool
    @Binding var isShowChinese:Bool
    ///实现在每个row上点按可以单独开启
    @State var isShowEnglishSingle:Bool=false
    @State var isShowChineseSingle:Bool=false

    var word:singleWord
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("\(getText(input: "chinese"))")
                    .onTapGesture {
                        isShowChineseSingle.toggle()
                    }
                Text(word.name)
                    .font(.title3)
                    .foregroundColor((!isShowChinese)||(isShowChineseSingle) ? Color.black : Color.clear)
            }
            HStack {
                Text("\(getText(input: "english"))")
                    .onTapGesture {
                        isShowEnglishSingle.toggle()
                    }
                Text(word.definition)
                    .font(.subheadline)
                    .foregroundColor((!isShowEnglish)||(isShowEnglishSingle) ? Color.gray : Color.clear)
            }
        }
    }
    func getText(input:String)->String{
        if((!isShowEnglish) && (!isShowChinese)){
            return ""
        }else if(input=="chinese" && !isShowChinese){
            return ""
        }else if(input=="chinese" && isShowChinese){
            return "◯"
        }else if(input=="english" && !isShowEnglish){
            return ""
        }else if(input=="english" && isShowEnglish){
            return "◯"
        }else{
            ///永远不会到的
            return "unknown"
        }
    }
}
//
//struct ListRow_Previews: PreviewProvider {
//    static var word = ModelDataClass().word
//    static var previews: some View {
//        ListRow(word: word[0])
//            .environmentObject(ModelDataClass())
//    }
//}
