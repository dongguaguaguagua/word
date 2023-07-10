import Foundation
import SQLite

func fetchData(word:String)->[DictStruct]{
    var result:[DictStruct]=[]
    do {
        let db = try Connection("/Users/huzongyu/Downloads/ECDICT/sqlite.db")
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
        
        let res1 = dict.filter(swName.like("\(word)%")).limit(20)
        let res2 = dict.filter(swName.like("%\(word)%")).limit(20)
        
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
            if(result.count == 20){
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
//        let word = dict.filter(id == rowid)
//        print(word)
//        let respond = dict.filter(swName.match("community"))
        

//        print("---------------------")
//        let Vdict = VirtualTable("VDict")
//        let Vid = Expression<Int64>("id")
//        let Vname = Expression<String?>("word")
//        let VswName = Expression<String?>("sw")
//        let Vphonetic = Expression<String?>("phonetic")
//        let Vtranslation = Expression<String?>("translation")
//
//        try db.run(Vdict.create(.FTS4([Vid,Vname,VswName,Vphonetic,Vtranslation], tokenize: .Porter)))
//        for singleWord in try db.prepare(dict) {
//                try db.run(Vdict.insert(
//                    Vid <- singleWord[id],
//                    Vname <- singleWord[name],
//                    VswName <- singleWord[swName],
//                    Vphonetic <- singleWord[phonetic],
//                    Vtranslation <- singleWord[translation]
//                ))
//            }
//        let respond = Vdict.filter(VswName.match(word))
//        for singleWord in try db.prepare(respond){
//            print("word: \(singleWord[name] ?? "")")
//            print("translation: \(singleWord[translation] ?? "")")
//            result.append(singleWord[name] ?? "")
//        }
    } catch {
        print (error)
    }
    return result
}
