//
//  NewsDetailViewModel.swift
//  BombNews
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import Foundation

// MARK: - NewsDetailViewModel
final class NewsDetailViewModel: BaseViewModel<NewsDetailViewStates> {
    
    private var newsDetail: Article
    @Published var newsType: NewsDetailTypes  = .reader
    
    private(set) var newsTypeArray: [NewsDetailTypes] = NewsDetailTypes.allCases
    private(set) var imageString: String = ""
    private(set) var newsTitle: String = ""
    private(set) var newsDesc: String = ""
    private(set) var newsUrl: String = ""
    private(set) var source: String = ""
    
    init(newsDetail: Article) {
        self.newsDetail = newsDetail
        super.init()
        self.prepareContents()
    }
    
    func prepareContents() {
        guard let title = newsDetail.title,
              let desc = newsDetail.description,
              let newsUrl = newsDetail.url,
              let imageString = newsDetail.urlToImage,
              let source = newsDetail.source?.name else { return changeState(.empty) }
        
        self.newsTitle = title
        self.newsDesc = desc
        self.imageString = imageString
        self.newsUrl = newsUrl
        self.source = source
    }
    
    func changeNewsType() {
        changeState(newsType == .web ? .web : .ready)
    }
}
