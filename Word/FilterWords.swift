//
//  FilterWords.swift
//  Word
//
//  Created by 胡宗禹 on 6/27/23.
//

import Foundation

func filteredWords(data:[singleWord],tag:String)->[singleWord]{
    if(tag=="全部"){
        return data
    }else{
        return  tag=="无标签" ? data.filter({$0.tag==[""]}) : data.filter({$0.tag.contains(tag)})
    }
}
