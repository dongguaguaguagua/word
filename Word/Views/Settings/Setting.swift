//
//  Settings.swift
//  Word
//
//  Created by 胡宗禹 on 7/6/23.
//

import SwiftUI

struct Setting: View {
    @EnvironmentObject var ModelData:ModelDataClass
    var body: some View {
        NavigationView{
            Form(){
                Section(header:Text("外观")){
                    Toggle(isOn: $ModelData.settings.showDetailDefinition) {
                        Text("显示完整释义")
                    }
                }
            }.navigationTitle("设置")
        }.navigationTitle("设置")
    }
}
//
//struct Settings_Previews: PreviewProvider {
//    static var previews: some View {
//        Settings()
//    }
//}
