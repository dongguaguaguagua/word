//
//  manage.swift
//  Word
//
//  Created by 胡宗禹 on 6/24/23.
//

import SwiftUI

struct Manage: View {
    @EnvironmentObject var ModelData:ModelDataClass
    
    var body: some View {
        NavigationView{
            List{
                ForEach(getTags(data: ModelData.word),id: \.self){tag in
                    NavigationLink(){
                        eachTagList(tag: tag)
                    }label: {
                        Text(tag)
                    }
                }
            }
            .navigationTitle("标签")
        }
    }
}

struct Manage_Previews: PreviewProvider {
    static var previews: some View {
        Manage()
    }
}
