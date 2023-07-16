//
//  LoadData.swift
//  WordList
//
//  Created by 胡宗禹 on 6/24/23.
//

import Combine
import Foundation

class ModelDataClass: ObservableObject {
    @Published var word: [singleWord] = loadWords()
    @Published var tag: [singleTag] = loadTags()
    @Published var settings: settings = loadSettings()
}

func loadWords<T: Decodable>() ->T {
    let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "data.json"

    /// Initialize in case the file is empty.
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
                \"id\": \"\(UUID())\",
                \"name\": \"massacre\",
                \"definition\":\"n. 大屠杀，惨败 vt. 大屠杀，彻底击败，把…搞砸\",
                \"date\":\"\(getCurrentTime(timeFormat: .YYYYMMDDHHMMSS))\",
                \"tag\":["作文"]
            }
        ]
        """.data(using: .utf8)!)
    }
    try? fileHandle.close()
    let data: Data
    let fileUrl = URL(fileURLWithPath: file)
//    guard let file=Bundle.main.url(forResource: filename, withExtension: nil)
//    else{
//        fatalError("Couldn't find data file in main bundle.")
//    }
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
        {"showDetailDefinition":true}
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
