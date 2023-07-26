//
//  connectToDB.swift
//  Word
//
//  Created by 胡宗尧 on 7/24/23.
//
import SwiftUI

struct DownloadView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Button("Download File") {
                    downloadFile()
                }
                Spacer()
            }
        }
    }
    
    func downloadFile() {
        guard let url = URL(string: "https://gitee.com/pumpkin_melon/mirror0/releases/download/2.0.0/Sound-En.db") else {
            return
        }
        
        let task = URLSession.shared.downloadTask(with: url) { location, _, error in
            if let location = location {
                // 文件下载成功后的本地路径
                let destinationURL = getDocumentsDirectory().appendingPathComponent("Sound-En.db")
                do {
                    try FileManager.default.moveItem(at: location, to: destinationURL)
                    print("File downloaded to: \(destinationURL)")
                } catch {
                    print("Error moving file: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
