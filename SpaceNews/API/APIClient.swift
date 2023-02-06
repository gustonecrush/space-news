//
//  APIClient.swift
//  SpaceNews
//
//  Created by A Farhan Agustiansyah on 06/02/23.
//
//  API endpoint: https://api.spaceflightnewsapi.net/v3/articles

import Foundation

// data class space data
struct SpaceData : Codable, Identifiable {
    var id: Int
    var title: String
    var url: String
    var imageUrl: String
    var newsSite: String
    var summary: String
    var publishedAt: String
}

@MainActor class SpaceAPI : ObservableObject {
    @Published var news: [SpaceData] = []
    
    func getData() {
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v3/articles") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                let tempError = error!.localizedDescription
                DispatchQueue.main.async {
                    self.news = [SpaceData(id: 0, title: tempError, url: "Error", imageUrl: "Error",
                                           newsSite: "Error", summary: "Try swiping down to refresh as soon as you have internet", publishedAt: "Error" )]
                }
                return
            }
            
            let spaceData = try! JSONDecoder().decode([SpaceData].self, from: data)
            DispatchQueue.main.async {
                print("Loaded new data successfully. Articles: \(spaceData.count)")
                self.news = spaceData
            }
        }.resume()
    }
}