//
//  ImporanceButton.swift
//  Word
//
//  Created by 胡宗禹 on 7/17/23.
//

import SwiftUI

struct ImporanceButton: View {
    @EnvironmentObject var ModelData:ModelDataClass
    let index:Int
    var body: some View {
        Button(action: {
            if(ModelData.word[index].importance <= 10){
                ModelData.word[index].importance += 1
            }
        }) {
            Rectangle()
                .frame(width: 20)
                .fixedSize(horizontal: true, vertical: false)
                .foregroundColor(.red)
                .opacity(Double(ModelData.word[index].importance)/10)
        }.buttonStyle(BorderlessButtonStyle())
        
    }
}

