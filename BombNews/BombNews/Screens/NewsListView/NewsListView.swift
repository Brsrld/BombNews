//
//  NewsListView.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import SwiftUI

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
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack {
            switch viewModel.states {
            case .ready:
                EmptyView()
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
            .frame(width: 250)
            .padding(.bottom, 8)
            .onChange(of: viewModel.searchQuery) {
                if viewModel.segmentValue == .localSearch {
                    viewModel.filterData()
                }
            }
            .onSubmit(of: .search) {
                if viewModel.segmentValue == .deepSearch {
                    viewModel.checkValidation()
                }
            }
        }
    }
    
    @ViewBuilder
    private func newsList() -> some View {
        StaggeredGrid(list: viewModel.filteredNews,
                      columns: 2,
                      showsIndicator: false,
                      spacing: 12) { news in
            NavigationLink {
                LazyView(EmptyView())
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
