//
//  ImporanceButton.swift
//  Word
//
//  Created by 胡宗禹 on 7/17/23.
//

import BottomSheet
import PartialSheet
import SwiftUI
struct moreImportanceButton: View {
    @EnvironmentObject var ModelData: ModelDataClass
    let word: singleWord
    var body: some View {
        let index = ModelData.word.firstIndex(where: { $0.id==word.id }) ?? 0
        let extent: Double = (10.0 - ModelData.word[index].importance) / 10.0
        Rectangle()
            .onTapGesture {
                if ModelData.word[index].importance < 10 {
                    ModelData.word[index].importance += 1.0
                }
            }
            .frame(width: 20)
            .fixedSize(horizontal: true, vertical: false)
            .foregroundColor(Color(red: 1, green: extent, blue: extent))
    }
}

struct lessImportanceButton: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @State var isShowSlide: Bool = false

    let word: singleWord
    var body: some View {
        let index = ModelData.word.firstIndex(where: { $0.id==word.id }) ?? 0
        Button {
            isShowSlide = true
        } label: {
            Label("less importance", systemImage: "arrow.uturn.backward.circle")
        }
        .partialSheet(isPresented: $isShowSlide) {
            VStack {
                Text("change_importance")
                    .font(.title3)
                Slider(value: $ModelData.word[index].importance, in: 0 ... 10, step: 1)
            }.padding()
        }
    }
}
