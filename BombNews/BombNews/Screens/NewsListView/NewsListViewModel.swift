//
//  NewsListViewModel.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import Foundation

// MARK: - NewsListViewModel
final class NewsListViewModel: BaseViewModel<NewsListViewStates> {
    
    private enum Constant {
        static let alertMessage: String = "Search string not valid"
        static let nilValue: String = ""
    }
    
    private var service: NewsListServiceable?
    private var allNews: [Article] = []
    
    @Published private(set) var filteredNews: [Article] = []
    @Published var searchQuery: String = Constant.nilValue
    @Published var segmentValue: Segments = .localSearch
    private(set) var segmentArray: [Segments] = Segments.allCases
    
    init(service: NewsListServiceable = NewsListService(service: HttpClient())) {
        self.service = service
    }
    
    func serviceInitialize() {
        fetchNews()
    }
    
    func search(isOnchange: Bool) {
        switch segmentValue {
        case .deepSearch:
            if !isOnchange {
                checkValidation()
            }
        case .localSearch:
            filterData()
        }
    }
    
    func prepareCellUIModel(model: Article) -> NewsCellUIModel {
        guard let owner = model.source?.name,
              let title = model.title,
              let date = model.publishedAt else { return NewsCellUIModel(imageUrl: Constant.nilValue,
                                                                         owner: Constant.nilValue,
                                                                         title: Constant.nilValue,
                                                                         date: Constant.nilValue)}
        
        return NewsCellUIModel(imageUrl: model.urlToImage ?? Constant.nilValue,
                               owner: owner,
                               title:  title,
                               date: date.calculateTime())
        
    }
    
    private func filterData() {
        if searchQuery.isEmpty {
            filteredNews = allNews
        } else {
            filteredNews = allNews.filter { $0.title?.lowercased().contains(searchQuery.lowercased()) == true }
        }
        changeState(filteredNews.isEmpty ? .empty : .finished)
    }
    
    private func checkValidation() {
        if searchQuery.isValid() {
            changeState(.error)
            self.alertMessage = Constant.alertMessage
            self.showAlert.toggle()
        } else {
            fetchSearchedNews()
        }
    }
    
    private func fetchNews() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service?.fetchAllNews()
            self.changeState(.finished)
            switch result {
            case .success(let success):
                guard let articles = success.articles else { return self.changeState(.empty) }
                DispatchQueue.main.async {
                    self.allNews = articles
                    self.filteredNews = articles
                    self.changeState(articles.count == 0 ? .empty : .finished)
                }
            case .failure(let failure):
                self.changeState(.error)
                self.showAlert.toggle()
                self.alertMessage = failure.customMessage
            case .none:
                fatalError()
            }
        }
    }
    
    private func fetchSearchedNews() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service?.fetchSearchedNews(searchText: searchQuery)
            self.changeState(.finished)
            switch result {
            case .success(let success):
                guard let articles = success.articles else { return }
                DispatchQueue.main.async {
                    self.allNews = articles
                    self.filteredNews = articles
                    self.changeState(articles.count == 0 ? .empty : .finished)
                }
            case .failure(let failure):
                self.changeState(.error)
                self.showAlert.toggle()
                self.alertMessage = failure.customMessage
            case .none:
                fatalError()
            }
        }
    }
}
