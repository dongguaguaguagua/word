//
//  manage.swift
//  Word
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI
import UIKit
import PartialSheet


struct Manage: View {
    @EnvironmentObject var ModelData:ModelDataClass
    @State var isShowEditField:Bool=false
    @State var isShowRenameTagSheet:Bool=false
    @State var tagName:String=""
    @State var editMode:EditMode = .inactive
    @State var editItem:singleTag?=nil
    var noTagWord:[singleWord]{
        ModelData.word.filter({$0.tag==[]})
    }
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink(){
                    NoTagList()
                }label: {
                    HStack{
                        Text("无标签")
                        Spacer()
                        Text("\(noTagWord.count)")
                            .bold()
                            .foregroundColor(.pink)
                    }
                }
                
                ForEach(ModelData.tag,id: \.self){tag in
                    NavigationLink(){
                        EachTagList(tag: tag.name)
                    }label: {
                        HStack{
                            Circle()
                                .fixedSize()
                                .foregroundColor(Color(hex: tag.color))
                            Text(tag.name)
                            Spacer()
                            Text("\(getFilteredWordsCount(data:ModelData.word,tag:tag.name))")
                                .bold()
                                .foregroundColor(.pink)
                        }
                        ///drag action
                        .onDrag {
                            let provider = NSItemProvider.init(object: NSString(string: tag.name))
                            return provider
                        }
                        ///swipe action
                        .swipeActions(edge: .trailing) {
                            deleteButton(tag: tag.name)
                            Button(){
                                self.isShowRenameTagSheet=true
                                editItem=tag
                            }label: {
                                Label("Rename",systemImage: "character.cursor.ibeam")
                            }
                            .tint(.blue)
                        }
                    }
                }
                .onMove { fromSet, to in
                    ModelData.tag.move(fromOffsets: fromSet, toOffset: to)
                    saveTags(data: ModelData.tag)
                }
            }
            .sheet(item: $editItem){item in
                ///将数据中的hex转化为color
                let hexColor:String=item.color
                let tagColor:Color=Color(hex: hexColor)
                editTagSheet(orinigalName: item.name, tagName: item.name, tagColor: tagColor, isShowRenameTagSheet: $isShowRenameTagSheet)
            }
            .environment(\.editMode, $editMode)
            .navigationTitle("标签")
            .toolbar(){
                ToolbarItem(placement: .primaryAction){
                    AddTag()
                }
            }
        }
    }
}

struct editTagSheet:View{
    @EnvironmentObject var ModelData:ModelDataClass
    let orinigalName:String
    @State var tagName:String
    @State var tagColor:Color

    @Binding var isShowRenameTagSheet:Bool
    @State private var showAlert:Bool=false
    var body: some View{
        NavigationView{
            VStack {
                Text("编辑标签")
                    .font(.title2)
                Divider()
                TextField("标签名称", text: $tagName)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Divider()
                ColorPicker("选择一个颜色", selection: $tagColor)
                    .padding()
                Divider()
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("完成"){
                        if(ModelData.tag.map{$0.name}.contains(tagName) && tagName != orinigalName){
                            showAlert=true
                        }else{
                            let index=ModelData.tag.firstIndex(where: {$0.name==orinigalName})
                            ModelData.tag[index!].name=tagName
                            print("tagColor:\(tagColor.description)")
                            if(tagColor.description.count>=21){
                                ModelData.tag[index!].color=tagColor.hexString ?? "#000000"
                            }
                            self.dismiss()
                            saveTags(data: ModelData.tag)
                        }
                    }
                }
                ToolbarItem(placement: .navigation){
                    Button("取消"){
                        self.dismiss()
                    }
                }
            }
            .alert("标签已存在", isPresented: $showAlert){}
        }
    }
    private func dismiss() {
        /// 关闭 sheet 视图的方法
        /// 通过修改绑定的状态变量来实现
        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

struct deleteButton:View{
    @EnvironmentObject var ModelData:ModelDataClass
    
    var tag:String
    var body: some View{
        ///删除标签
        Button(role: .destructive) {
            for i in 0..<ModelData.word.count{
                ModelData.word[i].tag.removeAll(where: {$0==tag})
            }
            ModelData.tag.removeAll(where: {$0.name==tag})
            saveData(data: ModelData.word)
            saveTags(data: ModelData.tag)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}

struct Manage_Previews: PreviewProvider {
    static var previews: some View {
        Manage()
    }
}
