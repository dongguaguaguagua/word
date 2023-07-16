//
//  AddTag.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import SwiftUI

struct AddTag: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @State var newTag: String=""
    @State var showAddTagSheet=false
    var body: some View {
        Button {
            self.showAddTagSheet=true
        } label: {
            Label("Add", systemImage: "plus")
        }
        .sheet(isPresented: $showAddTagSheet) {
            newTagSheet(showAddTagSheet: $showAddTagSheet)
        }
    }
}

struct newTagSheet: View {
    @EnvironmentObject var ModelData: ModelDataClass
    @State var tagName: String=""
    @Binding var showAddTagSheet: Bool
    @State private var tagColor=Color(.sRGB, red: 0, green: 0, blue: 0)
    @State private var showAlert: Bool=false
    var body: some View {
        NavigationView {
            VStack {
                Text("add_tag")
                    .font(.title2)
                Divider()
                TextField("tag_name", text: $tagName)
                    .disableAutocorrection(ModelData.settings.disableAutoCorrection)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Divider()
                ColorPicker("choose_one_color", selection: $tagColor)
                    .padding()
                Text("default_color_note")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                Divider()
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("done") {
                        if (ModelData.tag.map { $0.name }.contains(tagName)) {
                            showAlert=true
                        } else {
                            if tagColor.description.count >= 21 {
                                ModelData.tag.append(singleTag(name: tagName, color: tagColor.hexString ?? "#000000"))
                            } else {
                                ModelData.tag.append(singleTag(name: tagName, color: "#000000"))
                            }
                            self.showAddTagSheet=false
                            saveTags(data: ModelData.tag)
                        }
                    }
                }
                ToolbarItem(placement: .navigation) {
                    Button("cancel") {
                        self.showAddTagSheet=false
                    }
                }
            }
            .alert("tag_exist_alert", isPresented: $showAlert) {}
        }
    }
}

// struct AddTag_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTag()
//    }
// }
