//
//  NewsListView.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import SwiftUI

// MARK: - NewsListView
struct NewsListView: View {
    @ObservedObject private var viewModel: NewsListViewModel
    
    init() {
        self._viewModel = ObservedObject(wrappedValue: NewsListViewModel())
    }
    
    var body: some View {
        BaseView(viewModel: viewModel){
            content()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("News List")
        .onLoad {
            viewModel.serviceInitialize()
        }
        .refreshable {
            viewModel.serviceInitialize()
        }
        .searchable(text: $viewModel.searchQuery,
                    placement: .toolbar,
                    prompt: "Find or search news")
        .onSubmit(of: .search) {
            if viewModel.segmentValue == .deepSearch {
                viewModel.checkValidation()
            }
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack {
            switch viewModel.states {
            case .ready:
                ProgressView("Loading")
            case .loading:
                ProgressView("Loading")
            case .finished:
                segmentedControl()
                newsList()
            case .error:
                ContentUnavailableView("No Results",
                                       systemImage: "exclamationmark.circle",
                                       description: Text("There is no news. You can use web search or refresh the page."))
            case .empty:
                ContentUnavailableView.search
                    .onChange(of: viewModel.searchQuery) {
                        if viewModel.segmentValue == .localSearch {
                            viewModel.filterData()
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    private func segmentedControl() -> some View {
        VStack {
            Picker("", selection: $viewModel.segmentValue) {
                ForEach(viewModel.segmentArray, id: \.self) {
                    Text($0.title)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: UIScreen.screenWidth / 1.5)
            .padding(.bottom, 8)
            .onChange(of: viewModel.searchQuery) {
                if viewModel.segmentValue == .localSearch {
                    viewModel.filterData()
                }
            }
        }
    }
    
    @ViewBuilder
    private func newsList() -> some View {
        StaggeredGrid(list: viewModel.filteredNews,
                      columns: UIScreen.screenWidth > 431.0 ? 3 : 2,
                      showsIndicator: false,
                      spacing: 12) { news in
            NavigationLink {
                LazyView(NewsDetailView(newsDetail: news))
            } label: {
                NewsCell(item: NewsCellItem(imageUrl: news.urlToImage ?? "",
                                            owner: news.source?.name ?? "",
                                            title: news.title ?? "",
                                            date: news.publishedAt?.calculateTime() ?? ""))
            }
        }
    }
}

#Preview {
    NewsListView()
}
