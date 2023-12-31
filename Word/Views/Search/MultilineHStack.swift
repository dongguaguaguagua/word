//
//  MultilineHStack.swift
//  Word
//
//  Created by 胡宗尧 on 7/22/23.
//

import SwiftUI

public struct MultilineHStack: View {
    struct SizePreferenceKey: PreferenceKey {
        typealias Value = [CGSize]
        static var defaultValue: Value = []
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value.append(contentsOf: nextValue())
        }
    }

    private let items: [AnyView]
    @State private var sizes: [CGSize] = []

    public init<Data: RandomAccessCollection, Content: View>(_ data: Data, @ViewBuilder content: (Data.Element) -> Content) {
        self.items = data.map { AnyView(content($0)) }
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(0 ..< self.items.count) { index in
                    self.items[index].background(self.backgroundView()).offset(self.getOffset(at: index, geometry: geometry))
                }
            }
        }.onPreferenceChange(SizePreferenceKey.self) {
            self.sizes = $0
        }
    }

    private func getOffset(at index: Int, geometry: GeometryProxy) -> CGSize {
        guard index < sizes.endIndex else { return .zero }
        let frame = sizes[index]
        var (x, y, maxHeight) = sizes[..<index].reduce((CGFloat.zero, CGFloat.zero, CGFloat.zero)) {
            var (x, y, maxHeight) = $0
            x += $1.width
            if x > geometry.size.width {
                x = $1.width
                y += maxHeight
                maxHeight = 0
            }
            maxHeight = max(maxHeight, $1.height)
            return (x, y, maxHeight)
        }
        if x + frame.width > geometry.size.width {
            x = 0
            y += maxHeight
        }
        return .init(width: x, height: y)
    }

    private func backgroundView() -> some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(
                    key: SizePreferenceKey.self,
                    value: [geometry.frame(in: CoordinateSpace.global).size]
                )
        }
    }
}
