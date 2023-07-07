//
//  PropertyWrapper.swift
//  Word
//
//  Created by 胡宗禹 on 7/7/23.
//
import Foundation
import Combine

//@propertyWrapper
//struct UserDefault<T> {
//    let key: String
//    let defaultValue: T
//
//    init(_ key: String, defaultValue: T) {
//        self.key = key
//        self.defaultValue = defaultValue
//    }
//
//    var wrappedValue: T {
//        get {
//            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: key)
//        }
//    }
//}
//
//final class UserSettings: ObservableObject {
//
//    let objectWillChange = PassthroughSubject<Void, Never>()
//
//    @UserDefault("ShowDetailDefinition", defaultValue: true)
//    var ShowDetailDefinition: Bool {
//        willSet {
//            objectWillChange.send()
//        }
//    }
//}

struct settings:Hashable,Codable{
    var showDetailDefinition:Bool
}
