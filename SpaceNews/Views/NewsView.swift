//
//  NewsView.swift
//  SpaceNews
//
//  Created by A Farhan Agustiansyah on 06/02/23.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var data : SpaceAPI
    @Environment(\.openURL) var openURL
    private var textWidth = 300.0
    
    var body: some View {
        if #available(iOS 15.0, *) {
            List {
                ForEach(data.news) { news in
                    NewsArticle(title: news.title, imageUrl: news.imageUrl, siteName: news.newsSite, summary: news.summary)
                        .onTapGesture {
                            openURL(URL(string: news.url)!)
                        }
                }
            }
            .refreshable {
                data.getData()
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .environmentObject(SpaceAPI())
    }
}
