//
//  LoadData.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import Foundation
import Combine

class ModelDataClass:ObservableObject{
    @Published var word: [singleWord] = load()
}

func load<T: Decodable>() ->T{
    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "data.json"
    
    ///防止文件为空,进行初始化操作
    if !FileManager.default.fileExists(atPath: file) {
        FileManager.default.createFile(atPath: file, contents: nil, attributes: nil)
    }
    let fileHandle = FileHandle(forWritingAtPath: file)!
    let fileLength = fileHandle.seekToEndOfFile()
    
    if(fileLength <= 1){
        
        fileHandle.seekToEndOfFile()
        fileHandle.write("""
            [
            {
                \"id\": \"\(UUID())\",
                \"name\": \"massacre\",
                \"definition\":\"n. 大屠杀，惨败 vt. 大屠杀，彻底击败，把…搞砸\",
                \"date\":\"2002-07-03 05:52:44\"
            },]
            """.data(using: .utf8)!)
    }
    try? fileHandle.close()
    print(file)
    let data:Data
    let fileUrl = URL(fileURLWithPath: file)
//    guard let file=Bundle.main.url(forResource: filename, withExtension: nil)
//    else{
//        fatalError("Couldn't find data file in main bundle.")
//    }
    do {
        data=try Data(contentsOf: fileUrl)
    }catch{
        fatalError("Couldn't load data file from main bundle:\n\(error)")
    }
    do {
        let decoder=JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }catch{
        fatalError("Couldn't parse data file as \(T.self):\n\(error)")
    }
}

func writeData(newWord : singleWord){
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "data.json"
    if !FileManager.default.fileExists(atPath: path) {
        FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
    }
    let fileHandle = FileHandle(forWritingAtPath: path)!
    let fileLength = fileHandle.seekToEndOfFile()
    print(fileLength)
    ///防止文件为空
    if(fileLength <= 1){
        fileHandle.seekToEndOfFile()
        fileHandle.write("""
            [
            {
                \"id\": \"\(UUID())\",
                \"name\": \"\(newWord.name)\",
                \"definition\":\"\(newWord.definition)\",
                \"date\":\"\(newWord.date)\"
            },]
            """.data(using: .utf8)!)
    }else{
        try? fileHandle.seek(toOffset: fileLength-1)
        fileHandle.write("""
        {
            \"id\": \"\(UUID())\",
            \"name\": \"\(newWord.name)\",
            \"definition\":\"\(newWord.definition)\",
            \"date\":\"\(newWord.date)\"
        },]
        """.data(using: .utf8)!)
    }
    try? fileHandle.close()
}
