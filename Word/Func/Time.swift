//
//  Time.swift
//  Word
//
//  Created by 胡宗禹 on 6/25/23.
//

import Foundation

///get the current time. This function is used when creating or editing a word.
///The return value will be inserted to the `date` attribute, which can be really helpful to sort words.
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
