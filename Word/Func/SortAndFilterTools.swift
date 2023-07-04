//
//  FilterWords.swift
//  Word
//
//  Created by 胡宗禹 on 6/27/23.
//

import Foundation

enum SortMode: String, CaseIterable, Identifiable {
    case byDateUp, byDateDown, byNameUp, byNameDown, random
    var id: Self { self }
}

///接收`sortMode`作为参数,返回的是排序好的`ModelData`
func sortWords(sortMode: SortMode,data: [singleWord]) -> [singleWord] {
    switch sortMode {
    case .byDateUp:
        return data.sorted { $0.date < $1.date }
    case .byDateDown:
        return data.sorted { $0.date > $1.date }
    case .byNameUp:
        return data.sorted { $0.name < $1.name }
    case .byNameDown:
        return data.sorted { $0.name > $1.name }
    case .random:
        return data.shuffled()
        
        ///it can be done like this:
        ///```
        ///var shuffled = data
        ///for i in 0..<data.count {
        ///    let index = Int.random(in: i..<data.count)
        ///    if index != i {
        ///        shuffled.swapAt(i, index)
        ///    }
        ///}
        ///return shuffled
        ///```
    }
}

func filteredWords(data:[singleWord],tag:String)->[singleWord]{
    if(tag=="全部"){
        return data
    }else{
        return  tag=="无标签" ? data.filter({$0.tag==[]}) : data.filter({$0.tag.contains(tag)})
    }
}

func getFilteredWordsCount(data:[singleWord],tag:String)->Int{
    return filteredWords(data: data, tag: tag).count
}

func fromTagNameGetColor(data:[singleTag],Tag:String)->String{
    let name:[String]=data.map({$0.name})
    if(name.contains(Tag)){
        let index=data.firstIndex(where: {$0.name==Tag}) ?? 0
        return data[index].color
    }else{
        return ""
    }
}
