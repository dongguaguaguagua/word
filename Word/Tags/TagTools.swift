//
//  getTags.swift
//  Word
//
//  Created by 胡宗禹 on 6/26/23.
//

import Foundation

func getTags(data:[singleWord])->[String]
{
//    var tagData:[singleTag]=loadTags()
    var tags:[String]=[]
    for word in data{
        for tag in word.tag{
            if(!tags.contains(tag) && !(tag=="")){
                tags.append(tag)
//                tagData.append(singleTag(name: tag, color: ""))
            }
        }
    }
//    for tagDataTag in tagData{
//        if(!tags.contains(tagDataTag.name)){
//            tags.append(tagDataTag.name)
//        }
//    }
//    saveTags(tag: tagData)
    return tags
}


