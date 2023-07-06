//
//  ListRow.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

///This is the navigation label of each single word.
///It shows the word's name, definition. And provide button to hide or show them individually.
struct ListRow: View {
    @EnvironmentObject var ModelData:ModelDataClass
    
    @Binding var isShowEnglish:Bool
    @Binding var isShowChinese:Bool
    
    ///whether show Chinese or English individually
    @State var isShowEnglishSingle:Bool=false
    @State var isShowChineseSingle:Bool=false
    
    ///receive a word
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
                    ///The hide action is realized by modifying the color.(`Color.clear`)
                    .foregroundColor((!isShowChinese)||(isShowChineseSingle) ? Color.black : Color.clear)
                    ///ease in and out animation
                    .animation(.easeInOut(duration: 0.2),value: isShowChineseSingle)
            }
            HStack {
                Text("\(getText(input: "english"))")
                    .onTapGesture {
                        isShowEnglishSingle.toggle()
                    }
                Text(word.definition)
                    .font(.subheadline)
                    .foregroundColor((!isShowEnglish)||(isShowEnglishSingle) ? Color.gray : Color.clear)
                    .animation(.easeInOut(duration: 0.2),value: isShowEnglishSingle)
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
            ///This situation would never appear.
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
