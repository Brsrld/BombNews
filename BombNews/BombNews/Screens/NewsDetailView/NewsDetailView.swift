//
//  NewsDetailView.swift
//  BombNews
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import SwiftUI

// MARK: - NewsDetailView
struct NewsDetailView: View {
    
    private enum Constant {
        static let progressViewText: String = "Loading"
        static let emptyImageTitle: String = "Article does not have a image"
        static let emptyImageSystemImage: String  = "exclamationmark.circle"
        static let readerSpacing: CGFloat = 12
        static let segmentedSpacing: CGFloat = 8
        static let segmentedWidth: CGFloat = UIScreen.screenWidth / 1.5
        static let segmentedString: String = ""
        static let screenMaxSize: CGFloat = 933
        static let maxSizeImage: CGFloat = 3
        static let minSizeImage: CGFloat = 4
        static let segmentedIdentifier: String = "type"
    }
    
    @ObservedObject private var viewModel: NewsDetailViewModel
    @State var isloading = false
    
    init(newsDetail: Article) {
        self._viewModel = ObservedObject(wrappedValue: NewsDetailViewModel(newsDetail: newsDetail))
    }
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            content()
        }
        .navigationTitle(viewModel.source)
    }
    
    @ViewBuilder
    private func content() -> some View {
        VStack {
            switch viewModel.states {
            case .ready:
                segmentedControl()
                reader()
            case .web:
                segmentedControl()
                WebView(url: viewModel.newsUrl,
                        showLoading: $isloading)
                .overlay(isloading ? ProgressView(Constant.progressViewText).toAnyView() : EmptyView().toAnyView())
            case .empty:
                ContentUnavailableView(Constant.emptyImageTitle,
                                       systemImage: Constant.emptyImageSystemImage)
            }
        }
    }
    
    @ViewBuilder
    private func newsImage() -> some View {
        CacheAsyncImage(urlString: viewModel.imageString) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .frame(height: calculateHeight())
                    .scaledToFit()
            case .failure(_):
                EmptyView()
            @unknown default:
                fatalError()
            }
        }
    }
    
    private func calculateHeight() -> CGFloat {
        return UIScreen.screenHeight > Constant.screenMaxSize ?
        UIScreen.screenHeight / Constant.maxSizeImage :
        UIScreen.screenHeight / Constant.minSizeImage
    }
    
    @ViewBuilder
    private func labels() -> some View {
        Text(viewModel.newsTitle)
            .modifier(TextBuilder(textColor: .textColor,
                                  textFont: .title3,
                                  alingment: .center))
        Text(viewModel.newsDesc)
            .modifier(TextBuilder(textColor: .textColor,
                                  textFont: .subheadline,
                                  alingment: .leading))
            .padding(.horizontal, Constant.segmentedSpacing)
    }
    
    private func reader() -> some View {
        ScrollView {
            LazyVStack(spacing: Constant.readerSpacing) {
                newsImage()
                labels()
            }
            .padding(.bottom)
        }
    }
    
    private func segmentedControl() -> some View {
        VStack {
            Picker(Constant.segmentedString, selection: $viewModel.newsType) {
                ForEach(viewModel.newsTypeArray, id: \.self) {
                    Text($0.title)
                }
            }
            .pickerStyle(.segmented)
            .accessibilityIdentifier(Constant.segmentedIdentifier)
            .frame(width: Constant.segmentedWidth)
            .padding(.bottom, Constant.segmentedSpacing)
            .onChange(of: viewModel.newsType) {
                viewModel.changeNewsType()
            }
        }
    }
}

#Preview {
    NewsDetailView(newsDetail: Article(source: nil,
                                       author: nil,
                                       title: nil,
                                       description: nil,
                                       url: nil,
                                       urlToImage: nil,
                                       publishedAt: nil,
                                       content: nil))
}
