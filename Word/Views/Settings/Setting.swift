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
                Section(header:Text("gesture")){
                    Toggle(isOn: $ModelData.settings.clickBottomToShuffle) {
                        Text("click_bottom_to_shuffle")
                    }
                }
                Section(header:Text("auxiliary")){
                    Toggle(isOn: $ModelData.settings.disableAutoCorrection) {
                        Text("disable_auto_correction")
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
