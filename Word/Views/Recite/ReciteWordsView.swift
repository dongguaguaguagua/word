//
//  ReciteWordsView.swift
//  Word
//
//  Created by 胡宗尧 on 7/25/23.
//

import SwiftUI

struct BlurButtonView: View {
    @State var buttonText: String
    @State var buttonValue: Int
    @State var icon: String
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(buttonText)
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding(.bottom, 1)
                Text(String(buttonValue))
                    .foregroundColor(Color(hex: "#c13e2a"))
            }
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding(.leading, 20)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .font(.system(size: 14))
    }
}

struct ReciteWordsView: View {
    @EnvironmentObject var ModelData: ModelDataClass

    var body: some View {
        NavigationView {
            ZStack {
//                GeometryReader { geometry in
//                    if let image = ModelData.bingBackground.backgroundImage {
//                        Image(uiImage: image)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: geometry.size.width)
//                            .frame(maxHeight: .infinity)
//                            .edgesIgnoringSafeArea(.all)
//                    } else {
//                        Color.white
//                    }
//                }
//                VStack {
//                    if let msg = ModelData.bingBackground.imageMsg {
//                        Text("\(msg)")
//                            .font(.largeTitle)
//                            .bold()
//                            .padding(.top, 50)
//                    } else {
//                        Text("Good Morning")
//                            .font(.largeTitle)
//                            .bold()
//                            .padding(.top, 50)
//                    }
//                    Spacer()
//                    HStack {
//                        Group {
//                            NavigationLink {
//                                ReviewWordsView()
//                            } label: {
//                                BlurButtonView(buttonText: "Learn", buttonValue: 4989, icon: "book.closed.fill")
//                            }
//                            NavigationLink {
//                                ReviewWordsView()
//                            } label: {
//                                BlurButtonView(buttonText: "Review", buttonValue: 18, icon: "memories")
//                            }
//                        }
//                        .background(.thinMaterial)
//                        .cornerRadius(12)
//                    }
//                    .padding(.bottom, 25)
//                }
//                .padding()
            }
        }
    }
}

struct ReciteWordsView_Previews: PreviewProvider {
    static var previews: some View {
        ReciteWordsView()
    }
}
