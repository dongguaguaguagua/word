//
//  Time.swift
//  Word
//
//  Created by 胡宗禹 on 6/25/23.
//

import Foundation

///获取当前时间
enum TimeFormat:String {
    case YYYYMMDD = "YYYY-MM-dd"
    case YYYYMMDDHH = "YYYY-MM-dd HH"
    case YYYYMMDDHHMM = "YYYY-MM-dd HH:mm"
    case YYYYMMDDHHMMSS = "YYYY-MM-dd HH:mm:ss"
    case YYYYMMDDHHMMSSsss = "YYYY-MM-dd HH:mm:ss.SSS"
}

func getCurrentTime(timeFormat:TimeFormat) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = timeFormat.rawValue
    let timezone = TimeZone.init(identifier: "Asia/Beijing")
    formatter.timeZone = timezone
    let dateTime = formatter.string(from: Date.init())
    return dateTime
}
