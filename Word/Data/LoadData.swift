//
//  LoadData.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import Combine
import Foundation
import SQLite

class ModelDataClass: ObservableObject {
    @Published var word: [singleWord] = loadWordsInSql()
    @Published var tag: [singleTag] = loadTags()
    @Published var settings: settings = loadSettings()
//    @Published var bingBackground: bingBackground = loadDefaultBg()
}
//
//func loadDefaultBg()->bingBackground {
//    let result = bingBackground(imageMsg: "", backgroundImage: UIImage())
//    return result
//}

func loadWordsInSql()->[singleWord] {
    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/WordData.db"
    var results: [singleWord] = []
    do {
        let db = try Connection(file)
        let NewWords = Table("Word")

        let id = Expression<UUID?>("id")
        let name = Expression<String?>("word")
        let definition = Expression<String?>("definition")
        let date = Expression<String?>("date")
        let tag = Expression<String?>("tag")
        let importance = Expression<Double?>("importance")

        for word in try db.prepare(NewWords) {
            var tags=word[tag]?.components(separatedBy: ",") ?? []
            if(tags==[""]){
                tags=[]
            }
            results.append(singleWord(id: word[id] ?? UUID(),
                                      name: word[name] ?? "",
                                      definition: word[definition] ?? "",
                                      date: word[date] ?? "",
                                      tag: tags,
                                      importance: word[importance] ?? 0.0))
        }
    } catch {
        print(error)
    }
    return results
}

func removeWordsInSql(uuid: Set<UUID>) {
    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/WordData.db"
    do {
        let db = try Connection(file)
        let NewWords = Table("Word")

        let id = Expression<UUID?>("id")

        let deletedWords = NewWords.filter(uuid.contains(id))

        try db.run(deletedWords.delete())
    } catch {
        print(error)
    }
}

func insertWordsInSql(word: singleWord) {
    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/WordData.db"
    do {
        let db = try Connection(file)
        let NewWords = Table("Word")

        let id = Expression<UUID?>("id")
        let name = Expression<String?>("word")
        let definition = Expression<String?>("definition")
        let date = Expression<String?>("date")
        let tag = Expression<String?>("tag")
        let importance = Expression<Double?>("importance")

        let insert = NewWords.insert(id<-word.id, name<-word.name, definition<-word.definition, date<-word.date, tag<-word.tag.joined(separator: ","), importance<-word.importance)

        try db.run(insert)
    } catch {
        print(error)
    }
}

func updateWordsInSql(wordId: UUID, wordName: String, wordDef: String, time: String) {
    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/WordData.db"
    do {
        let db = try Connection(file)
        let NewWords = Table("Word")

        let id = Expression<UUID?>("id")
        let name = Expression<String?>("word")
        let definition = Expression<String?>("definition")
        let date = Expression<String?>("date")
//        let tag = Expression<String?>("tag")
//        let importance = Expression<Double?>("importance")

        let editedWord = NewWords.filter(id == wordId)

        try db.run(editedWord.update(name<-wordName, definition<-wordDef, date<-time))

    } catch {
        print(error)
    }
}

func addTagInSql(wordId: Set<UUID>, selectedTag: [String]) {
    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/WordData.db"
    do {
        let db = try Connection(file)
        let NewWords = Table("Word")

        let id = Expression<UUID?>("id")
//        let name = Expression<String?>("word")
//        let definition = Expression<String?>("definition")
//        let date = Expression<String?>("date")
        let tag = Expression<String?>("tag")
//        let importance = Expression<Double?>("importance")

        let words = NewWords.filter(wordId.contains(id))

        try db.run(words.update(tag<-selectedTag.joined(separator: ",")))

    } catch {
        print(error)
    }
}

func deleteTagInSql(delTag: String) {
    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/WordData.db"
    do {
        let db = try Connection(file)
        let NewWords = Table("Word")

//        let id = Expression<UUID?>("id")
//        let name = Expression<String?>("word")
//        let definition = Expression<String?>("definition")
//        let date = Expression<String?>("date")
        let tag = Expression<String?>("tag")
//        let importance = Expression<Double?>("importance")

        for newWord in try db.prepare(NewWords){
            var tags=newWord[tag]?.components(separatedBy: ",")
            if((tags?.contains(delTag)) != nil){
                tags?.removeAll(where: {$0==delTag})
                try db.run(NewWords.update(tag<-tags?.joined(separator: ",")))
            }
        }

    } catch {
        print(error)
    }
}

//
// func loadWords<T: Decodable>() ->T {
//    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "data.json"
//
//    /// Initialize in case the file is empty.
//    if !FileManager.default.fileExists(atPath: file) {
//        FileManager.default.createFile(atPath: file, contents: nil, attributes: nil)
//    }
//    let fileHandle = FileHandle(forWritingAtPath: file)!
//    let fileLength = fileHandle.seekToEndOfFile()
//    print(file)
//    if fileLength <= 1 {
//        fileHandle.seekToEndOfFile()
//        fileHandle.write("""
//        [
//            {
//                \"id\": \"\(UUID())\",
//                \"name\": \"Guide 01\",
//                \"definition\":\"# This page will show you how to use this app.\n \n ![](https://github.com/dongguaguaguagua/word/raw/main/img/003.png)\n \n Click the adjust button to change the word’s importance (default to 0)\n \n Importance has 10 levels.\n",
//                \"date\":\"\(getCurrentTime(timeFormat: .YYYYMMDDHHMMSS))\",
//                \"tag\":["Guide For Starters"],
//                \"importance\":0
//            }
//        ]
//        """.data(using: .utf8)!)
//    }
//    try? fileHandle.close()
//    let data: Data
//    let fileUrl = URL(fileURLWithPath: file)
////    guard let file=Bundle.main.url(forResource: filename, withExtension: nil)
////    else{
////        fatalError("Couldn't find data file in main bundle.")
////    }
//    do {
//        data = try Data(contentsOf: fileUrl)
//    } catch {
//        fatalError("Couldn't load data file from main bundle:\n\(error)")
//    }
//    do {
//        let decoder = JSONDecoder()
//        return try decoder.decode(T.self, from: data)
//    } catch {
//        fatalError("Couldn't parse data file as \(T.self):\n\(error)")
//    }
// }

/// Write word data to the disk
func saveData(data: [singleWord]) {
    let encoder = JSONEncoder()

    /// encode `singleWord` to `JSON` data
    guard let jsonData = try? encoder.encode(data) else {
        fatalError("Could not encode data to json")
    }

    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "data.json"

    let fileUrl = URL(fileURLWithPath: path)
    do {
        try jsonData.write(to: fileUrl)
    } catch {
        fatalError("Error occurs when writing to json file")
    }
}

func loadTags<T: Decodable>() ->T {
    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "Tags.json"
    print(file)
    /// 防止文件为空,进行初始化操作
    if !FileManager.default.fileExists(atPath: file) {
        FileManager.default.createFile(atPath: file, contents: nil, attributes: nil)
    }
    let fileHandle = FileHandle(forWritingAtPath: file)!
    let fileLength = fileHandle.seekToEndOfFile()

    if fileLength <= 1 {
        fileHandle.seekToEndOfFile()
        fileHandle.write("""
        [
            {
                "id": "88155DA9-F30B-41EB-A426-47E452C405C5",
                "name": "作文",
                "color": "#000000"
            }
        ]
        """.data(using: .utf8)!)
    }
    try? fileHandle.close()
    let data: Data
    let fileUrl = URL(fileURLWithPath: file)
    do {
        data = try Data(contentsOf: fileUrl)
    } catch {
        fatalError("Couldn't load data file from main bundle:\n\(error)")
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse data file as \(T.self):\n\(error)")
    }
}

/// Write tag data to the disk
func saveTags(data: [singleTag]) {
    let encoder = JSONEncoder()

    /// 将 `singleWord` 数组编码为 `JSON` 数据
    guard let jsonData = try? encoder.encode(data) else {
        fatalError("Could not encode data to json")
    }

    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "Tags.json"

    let fileUrl = URL(fileURLWithPath: path)
    do {
        try jsonData.write(to: fileUrl)
    } catch {
        fatalError("Error occurs when writing to json file")
    }
}

func loadSettings<T: Decodable>() ->T {
    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "Settings.json"
    print(file)
    /// 防止文件为空,进行初始化操作
    if !FileManager.default.fileExists(atPath: file) {
        FileManager.default.createFile(atPath: file, contents: nil, attributes: nil)
    }
    let fileHandle = FileHandle(forWritingAtPath: file)!
    let fileLength = fileHandle.seekToEndOfFile()

    if fileLength <= 1 {
        fileHandle.seekToEndOfFile()
        fileHandle.write("""
        {"moreCompactLayout":false}
        """.data(using: .utf8)!)
    }
    try? fileHandle.close()
    let data: Data
    let fileUrl = URL(fileURLWithPath: file)
    do {
        data = try Data(contentsOf: fileUrl)
    } catch {
        fatalError("Couldn't load setting file from main bundle:\n\(error)")
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse setting file as \(T.self):\n\(error)")
    }
}

func saveSettings(data: settings) {
    let encoder = JSONEncoder()

    guard let jsonData = try? encoder.encode(data) else {
        fatalError("Could not encode setting to json")
    }

    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "Settings.json"

    let fileUrl = URL(fileURLWithPath: path)
    do {
        try jsonData.write(to: fileUrl)
    } catch {
        fatalError("Error occurs when writing to json file")
    }
}
