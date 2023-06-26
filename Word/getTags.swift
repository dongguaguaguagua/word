//
//  getTags.swift
//  Word
//
//  Created by 胡宗禹 on 6/26/23.
//

import Foundation

func getTags(data:[singleWord])->[String]
{
    var tags:[String]=["无标签"]
    for word in data{
        if(!tags.contains(word.tag) && !(word.tag=="")){
            tags.append(word.tag)
        }
    }
    return tags
}
