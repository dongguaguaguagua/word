//
//  EditButton.swift
//  Word
//
//  Created by 胡宗禹 on 7/4/23.
//

import SwiftUI

struct EditButton: View {
    @Binding var isEditMode: EditMode
    var body: some View {
        ///编辑按钮
        /// https://juejin.cn/post/6983640370403868702
        Button(isEditMode.isEditing ? "完成": "编辑") {
            switch isEditMode {
            case .active:
                self.isEditMode = .inactive
            case .inactive:
                self.isEditMode = .active
            default:
                break
            }
        }
    }
}
