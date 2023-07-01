//
//  ColorExtension.swift
//  Word
//
//  Created by 胡宗禹 on 7/1/23.
//

import Foundation
import SwiftUI

///十六进制颜色扩展
extension Color {

    ///https://stackoverflow.com/questions/57257704/how-can-i-change-a-swiftui-color-to-uicolor
    static func convert(_ color: Color) -> UIColor {
        return UIColor(color)
    }
    
    // UIColor -> Hex String
    var hexString: String? {
        let ds:String=self.description
        let splitedDs:[String.SubSequence]=ds.split(separator: " ")
        let red:CGFloat=self.StringToFloat(str: String(splitedDs[1]))
        let green:CGFloat=self.StringToFloat(str: String(splitedDs[2]))
        let blue:CGFloat=self.StringToFloat(str: String(splitedDs[3]))
        let alpha:CGFloat=self.StringToFloat(str: String(splitedDs[4]))
        print(red*255.000000)
        print(green*255.000000)
        print(blue*255.000000)
        print(alpha*255.000000)
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * 255.000000),
                Int(green * 255.000000),
                Int(blue * 255.000000)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(alpha * 255.000000),
                Int(red * 255.000000),
                Int(green * 255.000000),
                Int(blue * 255.000000)
            )
        }
    }

    // Hex String -> UIColor
    /// https://stackoverflow.com/questions/56874133/use-hex-color-in-swiftui
    init(hex: String) {
         let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
         var int: UInt64 = 0
         Scanner(string: hex).scanHexInt64(&int)
         let a, r, g, b: UInt64
         switch hex.count {
         case 3: // RGB (12-bit)
             (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
         case 6: // RGB (24-bit)
             (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
         case 8: // ARGB (32-bit)
             (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
         default:
             (a, r, g, b) = (1, 1, 1, 0)
         }

         self.init(
             .sRGB,
             red: Double(r) / 255,
             green: Double(g) / 255,
             blue:  Double(b) / 255,
             opacity: Double(a) / 255
         )
    }
    func StringToFloat(str:String)->(CGFloat){
        let string = str
        var cgFloat: CGFloat = 0

        if let doubleValue = Double(string)
        {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
}
