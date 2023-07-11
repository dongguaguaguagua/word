import Foundation
import SQLite

func fetchData(word:String)->[DictStruct]{
    var result:[DictStruct]=[]
    do {
        let db = try Connection("/Users/huzongyu/Downloads/ECDICT/sqlite.db")
        let CollinsDict = Table("Collins")
        let dict = Table("stardict")
        
        let id = Expression<Int64>("id")
        let name = Expression<String?>("word")
        let swName = Expression<String?>("sw")
        let phonetic = Expression<String?>("phonetic")
        let definition = Expression<String?>("definition")
        let translation = Expression<String?>("translation")
        let collins = Expression<Int?>("collins")
        let oxford = Expression<Int?>("oxford")
        let tag = Expression<String?>("tag")
        let bnc = Expression<Int?>("bnc")
        let frq = Expression<Int?>("frq")
        let exchange = Expression<String?>("exchange")
        
        ///collins 1-5
        let res1 = CollinsDict.filter(swName.like("\(word)%")).limit(5)
        
        let res2 = dict.filter(swName.like("\(word)%")).limit(20)
        let res3 = dict.filter(swName.like("%\(word)%")).limit(20)
        
        for word in try db.prepare(res1) {
//                print("""
//                    \(String(describing: word[name]))
//                """)
            result.append(DictStruct(id: Int(word[id]),
                                     name: word[name] ?? "",
                                     phonetic: word[phonetic] ?? "",
                                     definition: word[definition] ?? "",
                                     translation: word[translation] ?? "",
                                     collins: word[collins] ?? -1,
                                     oxford: word[oxford] ?? -1,
                                     tag: word[tag] ?? "",
                                     bnc: word[bnc] ?? -1,
                                     frq: word[frq] ?? -1,
                                     exchange: word[exchange] ?? ""))
        }
        
        for word in try db.prepare(res2) {
            if(result.count == 30){
                break
            }
            if(result.map{Int64($0.id)}.contains(word[id]))
            {
                continue
            }
            result.append(DictStruct(id: Int(word[id]),
                                     name: word[name] ?? "",
                                     phonetic: word[phonetic] ?? "",
                                     definition: word[definition] ?? "",
                                     translation: word[translation] ?? "",
                                     collins: word[collins] ?? -1,
                                     oxford: word[oxford] ?? -1,
                                     tag: word[tag] ?? "",
                                     bnc: word[bnc] ?? -1,
                                     frq: word[frq] ?? -1,
                                     exchange: word[exchange] ?? ""))
        }
        for word in try db.prepare(res3) {
            if(result.count == 40){
                break
            }
            if(result.map{Int64($0.id)}.contains(word[id]))
            {
                continue
            }
            result.append(DictStruct(id: Int(word[id]),
                                     name: word[name] ?? "",
                                     phonetic: word[phonetic] ?? "",
                                     definition: word[definition] ?? "",
                                     translation: word[translation] ?? "",
                                     collins: word[collins] ?? -1,
                                     oxford: word[oxford] ?? -1,
                                     tag: word[tag] ?? "",
                                     bnc: word[bnc] ?? -1,
                                     frq: word[frq] ?? -1,
                                     exchange: word[exchange] ?? ""))
        }
    } catch {
        print (error)
    }
    return result
}

func fetchDataFromWordName(word:String)->DictStruct{
    var result:DictStruct = DictStruct(id: 0, name: "", phonetic: "", definition: "", translation: "", collins: -1, oxford: -1, tag: "", bnc: -1, frq: -1, exchange: "")
    do {
        let db = try Connection("/Users/huzongyu/Downloads/ECDICT/sqlite.db")
        let CollinsDict = Table("Collins")
        let dict = Table("stardict")
        
        let id = Expression<Int64>("id")
        let name = Expression<String?>("word")
        let phonetic = Expression<String?>("phonetic")
        let definition = Expression<String?>("definition")
        let translation = Expression<String?>("translation")
        let collins = Expression<Int?>("collins")
        let oxford = Expression<Int?>("oxford")
        let tag = Expression<String?>("tag")
        let bnc = Expression<Int?>("bnc")
        let frq = Expression<Int?>("frq")
        let exchange = Expression<String?>("exchange")
        
        ///collins 1-5
        let res1 = CollinsDict.filter(name==word)
        let res2 = dict.filter(name==word)
        
        for res in try db.prepare(res1) {
            result=DictStruct(id: Int(res[id]),
                              name: word,
                              phonetic: res[phonetic] ?? "",
                              definition: res[definition] ?? "",
                              translation: res[translation] ?? "",
                              collins: res[collins] ?? -1,
                              oxford: res[oxford] ?? -1,
                              tag: res[tag] ?? "",
                              bnc: res[bnc] ?? -1,
                              frq: res[frq] ?? -1,
                              exchange: res[exchange] ?? "")
        }
        for res in try db.prepare(res2) {
            result=DictStruct(id: Int(res[id]),
                              name: word,
                              phonetic: res[phonetic] ?? "",
                              definition: res[definition] ?? "",
                              translation: res[translation] ?? "",
                              collins: res[collins] ?? -1,
                              oxford: res[oxford] ?? -1,
                              tag: res[tag] ?? "",
                              bnc: res[bnc] ?? -1,
                              frq: res[frq] ?? -1,
                              exchange: res[exchange] ?? "")
        }
        return result
    } catch {
        print (error)
    }
    return result
}
