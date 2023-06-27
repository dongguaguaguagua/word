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
        for tag in word.tag{
            if(!tags.contains(tag) && !(tag=="")){
                tags.append(tag)
            }
        }
    }
    return tags
}

