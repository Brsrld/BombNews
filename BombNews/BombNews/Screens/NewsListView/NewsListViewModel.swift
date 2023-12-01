//
//  NewsListViewModel.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import Foundation

final class NewsListViewModel: BaseViewModel<NewsListViewStates> {
    private var service: NewsListServiceable
    private var allNews: [Article]
    
    @Published private(set) var filteredNews: [Article]
    @Published var searchQuery: String
    @Published var segmentValue: Segments
    private(set) var segmentArray: [Segments]
    
    override init() {
        self.service = NewsListService()
        self.allNews = []
        self.filteredNews = []
        self.searchQuery = ""
        self.segmentValue = .localSearch
        self.segmentArray = Segments.allCases
    }
    
    func serviceInitialize() {
        fetchNews()
    }
    
    func changeStateToEmpty() {
        changeState(.empty)
    }
    
    func filterData() {
        if searchQuery.isEmpty {
            filteredNews = allNews
        } else {
            filteredNews = allNews.filter { $0.title?.lowercased().contains(searchQuery.lowercased()) == true }
        }
    }
    
    func checkValidation() {
        if searchQuery.isValid() {
            changeState(.error)
            self.alertMessage = "Search string not valid"
            self.showAlert.toggle()
        } else {
            fetchSearchedNews()
        }
    }
    
    private func fetchNews() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.fetchAllNews()
            self.changeState(.finished)
            switch result {
            case .success(let success):
                guard let articles = success.articles else { return }
                DispatchQueue.main.async {
                    self.allNews = articles
                    self.filteredNews = articles
                }
            case .failure(let failure):
                self.changeState(.error)
                self.showAlert.toggle()
                self.alertMessage = failure.customMessage
            }
        }
    }
    
    private func fetchSearchedNews() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.fetchSearchedNews(searchText: searchQuery)
            self.changeState(.finished)
            switch result {
            case .success(let success):
                guard let articles = success.articles else { return }
                DispatchQueue.main.async {
                    self.allNews = articles
                    self.filteredNews = articles
                }
            case .failure(let failure):
                self.changeState(.error)
                self.showAlert.toggle()
                self.alertMessage = failure.customMessage
            }
        }
    }
}
