//
//  ListDetail.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

struct ListDetail: View {
    @EnvironmentObject var ModelData:ModelDataClass
    var word:singleWord
    var body: some View {
        VStack {
            Text(word.name)
                .font(.title)
            Text("添加时间:\(word.date)")
                .foregroundColor(.gray)
            Spacer()
                .frame(minHeight: 10,maxHeight: 20)
            Text(word.definition)
                .font(.title2)
        }
    }
}

struct ListDetail_Previews: PreviewProvider {
    static var word=ModelDataClass().word
    static var previews: some View {
        ListDetail(word: word[0])
            .environmentObject(ModelDataClass())
    }
}
