//
//  NewsListView.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import SwiftUI

// MARK: - NewsListView
struct NewsListView: View {
    
    private enum Constant {
        static let navigationTitle: String = "News List"
        static let searchBarPlaceholder: String = "Find or search news"
        static let emptyImageSystemImage: String  = "exclamationmark.circle"
        static let progressViewText: String = "Loading"
        static let errorTitle: String = "No Results"
        static let errorDesc: String = "There is no news. You can use web search or refresh the page."
        static let viewsPadding: CGFloat = 8
        static let newsListSpacing: CGFloat = 12
        static let segmentedWidth: CGFloat = UIScreen.screenWidth / 1.5
        static let segmentedString: String = ""
        static let phoneScreenWidth: CGFloat = 431
        static let twoColumns: Int = 2
        static let threeColumns: Int = 3
    }
    
    @ObservedObject private var viewModel: NewsListViewModel
    
    init() {
        self._viewModel = ObservedObject(wrappedValue: NewsListViewModel())
    }
    
    var body: some View {
        BaseView(viewModel: viewModel){
            content()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Constant.navigationTitle)
        .onLoad {
            viewModel.serviceInitialize()
        }
        .searchable(text: $viewModel.searchQuery,
                    placement: .toolbar,
                    prompt: Constant.searchBarPlaceholder)
        .onSubmit(of: .search) {
            viewModel.search(isOnchange: false)
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack {
            switch viewModel.states {
            case .ready:
                ProgressView(Constant.progressViewText)
            case .loading:
                ProgressView(Constant.progressViewText)
            case .finished:
                segmentedControl()
                newsList()
            case .error:
                ContentUnavailableView(Constant.errorTitle,
                                       systemImage: Constant.emptyImageSystemImage,
                                       description: Text(Constant.errorDesc))
            case .empty:
                ContentUnavailableView.search
                    .onChange(of: viewModel.searchQuery) {
                        viewModel.search(isOnchange: true)
                    }
            }
        }
    }
    
    private func segmentedControl() -> some View {
        VStack {
            Picker(Constant.segmentedString, selection: $viewModel.segmentValue) {
                ForEach(viewModel.segmentArray, id: \.self) {
                    Text($0.title)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: Constant.segmentedWidth)
            .padding(.bottom, Constant.viewsPadding)
            .onChange(of: viewModel.searchQuery) {
                viewModel.search(isOnchange: true)
            }
        }
    }
    
    private func newsList() -> some View {
        StaggeredGrid(list: viewModel.filteredNews,
                      columns: calculateColumns(),
                      showsIndicator: false,
                      spacing: Constant.newsListSpacing) { news in
            NavigationLink {
                LazyView(NewsDetailView(newsDetail: news))
            } label: {
                NewsCell(item: viewModel.prepareCellUIModel(model: news))
            }
        }
                      .padding(.top, Constant.viewsPadding)
    }
    
    private func calculateColumns() -> Int {
        return UIScreen.screenWidth > Constant.phoneScreenWidth ?
        Constant.threeColumns : Constant.twoColumns
    }
}

#Preview {
    NewsListView()
}
