//
//  NewsListView.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import SwiftUI
import SwiftData

struct NewsListView: View {

    @StateObject var viewModel: NewsListViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        LoadingView(isLoading: $viewModel.isLoading) {
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach(viewModel.articles, id: \.self) { article in
                            NavigationLink(destination: NewsArticleDetailsView(article: article,
                                                                               storedArticles: viewModel.storedArticles)) {
                                NewsArticleRowView(article: article, storedArticles: viewModel.storedArticles)
                            }
                        }
                    }
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .font(.title)
                            .foregroundStyle(Color.black)
                            .padding(20)
                    }
                    
                }
                .navigationTitle("News")
                .navigationBarTitleDisplayMode(.inline)
                .task {
                    try? await viewModel.fetchArticles()
                }
                .onAppear {
                    self.viewModel.storedArticles = try! modelContext.fetch(FetchDescriptor<Article>())
                    print("stored count: \(self.viewModel.storedArticles.count)")
                }
            }
        }
    }
}
