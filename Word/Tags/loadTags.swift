//
//  loadTags.swift
//  Word
//
//  Created by 胡宗禹 on 6/28/23.
//

import Foundation

func loadTags<T: Decodable>() ->T{
    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "Tags.json"
    
    ///防止文件为空,进行初始化操作
    if !FileManager.default.fileExists(atPath: file) {
        FileManager.default.createFile(atPath: file, contents: nil, attributes: nil)
    }
    let fileHandle = FileHandle(forWritingAtPath: file)!
    let fileLength = fileHandle.seekToEndOfFile()
    
    if(fileLength <= 1){
        fileHandle.seekToEndOfFile()
        fileHandle.write("[]".data(using: .utf8)!)
    }
    try? fileHandle.close()
    print(file)
    let data:Data
    let fileUrl = URL(fileURLWithPath: file)
    
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

//func saveTags(tag:[singleTag]){
//    let encoder = JSONEncoder()
//
//    /// 将 `singleWord` 数组编码为 `JSON` 数据
//    guard let jsonData = try? encoder.encode(tag) else {
//        fatalError("Could not encode data to json")
//    }
//
//    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "Tags.json"
//
//    let fileUrl=URL(fileURLWithPath: path)
//    do {
//        try jsonData.write(to: fileUrl)
//    } catch {
//        fatalError("Error occurs when writing to json file")
//    }
//}
