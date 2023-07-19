//
//  RecordedSeal.swift
//  Word
//
//  Created by 胡宗尧 on 7/18/23.
//

import SwiftUI

struct RecordedSealView: View {
    @State var circleSize: CGFloat = 80
    @State var circleLineWidth: CGFloat = 2
    @State var dateText: String
    @State var recordedText: String = "RECORDED"

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.green, lineWidth: circleLineWidth)
                .frame(width: circleSize, height: circleSize)
            getOffsetForText(text: recordedText)

            Image(systemName: "star.circle.fill")
                .font(.system(size: circleSize / 3))
                .foregroundColor(.green)
            Text(getDate(date: dateText))
                .foregroundColor(.green)
                .offset(y: circleSize / 4 + circleSize / 20)
                .font(.system(size: circleSize / 10))
                .kerning(2)
                .bold()
        }
    }

    func getOffsetForText(text: String) -> some View {
        let radius = circleSize / 2 - circleSize / 6 // circle radius minus the text size
        let startAngle: Double = -Double(recordedText.count) * 10
        let endAngle = Double(recordedText.count) * 10
        return ForEach(Array(text.enumerated()), id: \.offset) { index, character in
            let angle: Double = startAngle + ((endAngle - startAngle) / Double(text.count - 1)) * Double(index)
            let x: CGFloat = radius * sin(angle * .pi / 180)
            let y: CGFloat = -radius * cos(angle * .pi / 180)
            Text(String(character))
                .font(.system(size: circleSize / 6))
                .fontWeight(.bold)
                .foregroundColor(.green)
                .rotationEffect(.degrees(angle))
                .offset(x: x, y: y)
        }
    }

    func getDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yy.MM.dd"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return "Invalid date format"
        }
    }
}

// struct RecordedSealView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordedSealView()
//    }
// }
