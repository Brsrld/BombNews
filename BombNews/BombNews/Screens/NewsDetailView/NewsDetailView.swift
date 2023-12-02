//
//  NewsDetailView.swift
//  BombNews
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import SwiftUI

struct NewsDetailView: View {
    
    @ObservedObject private var viewModel: NewsDetailViewModel
    @State var isloading = false
    
    init(newsDetail: Article) {
        self._viewModel = ObservedObject(wrappedValue: NewsDetailViewModel(newsDetail: newsDetail))
    }
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            content()
        }
        .navigationTitle(viewModel.newsDetail.source?.name ?? "")
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
                WebView(url: viewModel.newsDetail.url,
                        showLoading: $isloading)
                .overlay(isloading ? ProgressView("Loading").toAnyView() : EmptyView().toAnyView())
            }
        }
    }
    
    @ViewBuilder
    private func newsImage() -> some View {
        if let string = viewModel.newsDetail.urlToImage
            ,let url = URL(string: string) {
            
            CacheAsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .frame(height: 250)
                case .failure(_):
                   EmptyView()
                @unknown default:
                    fatalError()
                }
            }
        }
    }
    
    @ViewBuilder
    private func labels() -> some View {
        if let title = viewModel.newsDetail.title
            ,let desc = viewModel.newsDetail.description {
            
            Text(title)
                .modifier(TextBuilder(textColor: .black,
                                      textFont: .title3,
                                      alingment: .center))
            Text(desc)
                .modifier(TextBuilder(textColor: .gray,
                                      textFont: .subheadline,
                                      alingment: .leading))
                .padding(.horizontal, 8)
        }
    }
    
    @ViewBuilder
    private func reader() -> some View {
        ScrollView {
            LazyVStack(spacing: 12) {
               newsImage()
               labels()
            }
            .padding(.bottom)
        }
    }
    
    @ViewBuilder
    private func segmentedControl() -> some View {
        VStack {
            Picker("", selection: $viewModel.newsType) {
                ForEach(viewModel.newsTypeArray, id: \.self) {
                    Text($0.title)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 250)
            .padding(.bottom, 8)
            .onChange(of: viewModel.newsType) {
                viewModel.changeNewsType()
            }
        }
    }
}

#Preview {
    NewsDetailView(newsDetail: Article(source: nil,
                                       author: "Fatih Altayli",
                                       title: "Terim Fonu",
                                       description: nil,
                                       url: nil,
                                       urlToImage: nil,
                                       publishedAt: nil,
                                       content: nil))
}
