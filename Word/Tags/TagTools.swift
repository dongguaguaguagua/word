//
//  getTags.swift
//  Word
//
//  Created by 胡宗禹 on 6/26/23.
//

import Foundation

func getTags(data:[singleWord])->[String]
{
//    var tags:[String]=[]
//    for word in data{
//        for tag in word.tag{
//            if(!tags.contains(tag) && !(tag=="")){
//                tags.append(tag)
//            }
//        }
//    }
    return data.filter({$0.name=="__TAG_ITEM__"})[0].tag
}


