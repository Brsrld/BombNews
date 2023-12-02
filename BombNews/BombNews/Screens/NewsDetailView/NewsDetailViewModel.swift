//
//  NewsDetailViewModel.swift
//  BombNews
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import Foundation

final class NewsDetailViewModel: BaseViewModel<NewsDetailViewStates> {
    
    var newsDetail: Article
    @Published var newsType: NewsDetailTypes
    private(set) var newsTypeArray: [NewsDetailTypes]
    
    init(newsDetail: Article) {
        self.newsDetail = newsDetail
        self.newsType = .reader
        self.newsTypeArray = NewsDetailTypes.allCases
    }
    
    func changeNewsType() {
        changeState(newsType == .web ? .web : .ready)
    }
}
