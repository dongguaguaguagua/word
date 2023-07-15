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
    @State var showMaskSingleWord:Bool = true

    ///receive a word
    var word:singleWord
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                HStack() {
                    if (isShowChinese) {
                        VStack(alignment: .leading) {
                            if (showMaskSingleWord) {
                                Text("点击显示")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color.gray)
                                    .padding()
                            }else{
                                Spacer()
                                Text(word.name)
                                    .font(.title2)
                                    .foregroundColor(Color.black)
                                    .padding(.bottom, 2)
                                Text(word.date)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.black)
                                    .padding(.top, 2)
                                Spacer()
                            }
                        }
                        .frame(height: 70)
                        .frame(maxWidth: .infinity)
                        .background(showMaskSingleWord ? Color(red: 240/255, green: 240/255, blue: 240/255) : Color.white)
                        .cornerRadius(5)
                        .onTapGesture {
                            showMaskSingleWord = !showMaskSingleWord
                        }
                    }else{
                        VStack(alignment: .leading) {
                            Spacer()
                            Text(word.name)
                                .font(.title2)
                                .foregroundColor(Color.black)
                                .padding(.bottom, 2)
                            Text(word.date)
                                .font(.system(size: 12))
                                .foregroundColor(Color.black)
                                .padding(.top, 2)
                            Spacer()
                        }
                        .frame(height: 70)
                        .frame(maxWidth: .infinity)
                    }
                    Spacer()
                    if (isShowEnglish) {
                        VStack(alignment: .leading) {
                            if (showMaskSingleWord) {
                                Text("点击显示")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color.gray)
                                    .padding()
                            }else{
                                Text(word.definition)
                                    .font(.system(size: 15))
                                    .padding(.top, 1)
                                    .padding(.bottom, 1)
                                    .padding(.leading, 1)
                                    .padding(.trailing, 1)
                                    .foregroundColor(Color.gray)
                            }
                        }
                        .frame(height: 70)
                        .frame(maxWidth: .infinity)
                        .background(showMaskSingleWord ? Color(red: 240/255, green: 240/255, blue: 240/255) : Color.white)
                        .cornerRadius(5)
                        .onTapGesture {
                            showMaskSingleWord = !showMaskSingleWord
                        }
                    }else{
                        VStack(alignment: .leading) {
                            Text(word.definition)
                                .font(.system(size: 15))
                                .padding(.top, 1)
                                .padding(.bottom, 1)
                                .padding(.leading, 1)
                                .padding(.trailing, 1)
                                .foregroundColor(Color.gray)
                        }
                        .frame(height: 70)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

//struct ListRow_Previews: PreviewProvider {
//    static var word = ModelDataClass().word
//    static var previews: some View {
//        ListRow(word: word[0])
//            .environmentObject(ModelDataClass())
//    }
//}
