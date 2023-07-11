//
//  DetailView.swift
//  Word
//
//  Created by 胡宗禹 on 7/11/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var ModelData:ModelDataClass
    @State var word:DictStruct
    var body: some View {
        VStack(alignment: .leading){
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
        .padding()
        .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear{
            if(!ModelData.settings.recentSearchWord.contains(word.name)){
                ModelData.settings.recentSearchWord.append(word.name)
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
