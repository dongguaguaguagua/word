//
//  DetailView.swift
//  Word
//
//  Created by 胡宗禹 on 7/11/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @State var word: DictStruct
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(word.name)
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)
                Text("| "+word.phonetic+" |")
                    .font(.system(size: 15))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
            }
            Divider()
            List {
                Section(header: Text("Importance")) {
                    StarRatingView(rating: word.collins)
                    HStack {
                        Text("Bnc Rank")
                            .foregroundColor(Color.blue)
                        Spacer()
                        Text(String(word.bnc))
                            .foregroundColor(Color.black)
                    }
                }
                Section(header: Text("Chinese Translations")) {
                    let meaningList: [String] = word.translation.components(separatedBy: "\n")
                    ForEach(0..<meaningList.count, id: \.self) { index in
                        let meaning = meaningList[index]
                        let parts = meaning.components(separatedBy: " ")

                        HStack {
                            Text(parts[0]) // 词性
                                .foregroundColor(Color(red: 192/255, green: 77/255, blue: 71/255)) // 应用对应的颜色
                                .italic()
                            Text(parts.dropFirst().joined(separator: " "))
                                .foregroundColor(Color.black)
                        }
                    }
                }
                Section(header: Text("English Definitions")) {
                    let meaningList: [String] = word.definition.components(separatedBy: "\n")
                    ForEach(0..<meaningList.count, id: \.self) { index in
                        let meaning = meaningList[index]
                        let parts = meaning.components(separatedBy: " ")

                        HStack {
                            Text(parts[0]) // 词性
                                .foregroundColor(Color(red: 192/255, green: 77/255, blue: 71/255)) // 应用对应的颜色
                                .italic()
                            Text(parts.dropFirst().joined(separator: " "))
                                .foregroundColor(Color.black)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        .padding([.leading, .top, .trailing, .bottom], 0)
        .onAppear {
            if !ModelData.settings.recentSearchWord.contains(word.name) {
                ModelData.settings.recentSearchWord.append(word.name)
            }
        }
    }
}

struct StarRatingView: View {
    var rating: Int

    var body: some View {
        HStack {
            Text("Collins ")
                .foregroundColor(Color.blue)
            Spacer()
            ForEach(1 ... 5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
        }
    }
}

// struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
// }
