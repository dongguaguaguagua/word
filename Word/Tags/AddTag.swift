//
//  AddTag.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import SwiftUI

struct AddTag: View {
    @EnvironmentObject var ModelData:ModelDataClass
    @State var newTag:String = ""
    @State var showAddTagSheet=false
    var body: some View {
        Button(){
            self.showAddTagSheet=true
        }label: {
            Label("Add",systemImage: "plus")
        }
        .sheet(isPresented: $showAddTagSheet){
            newTagSheet(showAddTagSheet: $showAddTagSheet)
        }
    }
}

struct newTagSheet:View{
    @EnvironmentObject var ModelData:ModelDataClass
    @State var tagName:String = ""
    @Binding var showAddTagSheet:Bool
    @State private var tagColor = Color(.sRGB, red: 0, green: 0, blue: 0)
    @State private var showAlert:Bool=false
    var body: some View{
        NavigationView{
            VStack {
                Text("添加标签")
                    .font(.title2)
                Divider()
                TextField("标签名称", text: $tagName)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Divider()
                ColorPicker("选择一个颜色", selection: $tagColor)
                    .padding()
                Text("默认为黑色")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                Divider()
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("完成"){
                        if(ModelData.tag.map{$0.name}.contains(tagName)){
                            showAlert=true
                        }else{
                            ModelData.tag.append(singleTag(name: tagName, color: tagColor.hexString ?? "#000000"))
                            self.showAddTagSheet=false
                            saveTags(data: ModelData.tag)
                        }
                    }
                }
                ToolbarItem(placement: .navigation){
                    Button("取消"){
                        self.showAddTagSheet=false
                    }
                }
            }
            .alert("标签已存在", isPresented: $showAlert){}
        }
    }
}
//struct AddTag_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTag()
//    }
//}
