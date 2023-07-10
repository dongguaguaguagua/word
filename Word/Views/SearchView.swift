//
//  SearchView.swift
//  Word
//
//  Created by 胡宗禹 on 7/10/23.
//

import SwiftUI

struct SearchView: View {
    @State var searchWord:String = ""
    @State var searchResult:[DictStruct] = []
    var body: some View {
        VStack{
            TextField("search", text: $searchWord)
                .onChange(of: searchWord,perform:{ value in
                    let word = processInput(str: value)
                    print(word)
                    searchResult = fetchData(word: word)
                })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment:         .leading).padding(.leading, 8)
                )
                .padding(.horizontal, 10)
            List{
                ForEach(searchResult,id: \.self){word in
                    HStack{
                        hilightedText(str: word.name, searched: searchWord)
//                        Text(word.name)
//                            .foregroundColor(.gray)
                            .lineLimit(1)
                        Spacer()
                        Text(word.translation)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
