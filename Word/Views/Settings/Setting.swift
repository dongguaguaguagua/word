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
                Section(header:Text("appearance")){
                    Toggle(isOn: $ModelData.settings.showDetailDefinition) {
                        Text("show_full_definition")
                    }
                }
            }.navigationTitle("Setting")
        }
    }
}
//
//struct Settings_Previews: PreviewProvider {
//    static var previews: some View {
//        Settings()
//    }
//}
