//
//  DetailView.swift
//  Word
//
//  Created by 胡宗禹 on 7/11/23.
//

import SwiftUI

struct DetailView: View {
    @State var word:DictStruct
    var body: some View {
        HStack{
            Text(word.name)
                .font(.title)
            Text(word.phonetic)
                .font(.subheadline)
            HStack{
                Text("Collins \(word.collins) stars")
                Text("Bnc: \(word.bnc)")
                Text("Oxford: \(word.oxford)")
            }
            Text(word.translation)
            Text(word.definition)
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
