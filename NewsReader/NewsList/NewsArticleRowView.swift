//
//  NewsArticleRowView.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftData

struct NewsArticleRowView: View {
    
    let article: Article
    let storedArticles: [Article]
    @State var isFavorite: Bool = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            WebImage(url: URL(string: article.media?.first?.mediaMetadata?.first?.url ?? "")) { image in
                image.resizable()
            } placeholder: {
                RoundedRectangle(cornerRadius: 5).foregroundColor(.gray)
            }
            .onSuccess() {_,_,_ in
                
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 75, height: 75, alignment: .center)
            .background(Color.gray)
            .cornerRadius(5)
            .clipped()
            .padding([.leading, .top], 10)

            // article information
            articleInfoView

        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 0)
        .padding(.horizontal, 10)
        .padding(.top, 5)
        .onAppear {
            self.isFavorite = storedArticles.contains(where: { $0.id == article.id })
        }
    }
    
    private var articleInfoView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(article.title ?? "")
                .font(.headline)
                .foregroundStyle(Color.black)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .padding([.trailing, .top], 10)
            Text(article.author ?? "")
                .font(.caption)
                .foregroundStyle(Color.black)
                .multilineTextAlignment(.leading)
                .padding(.trailing, 10)

            HStack(spacing: 20) {
                Spacer(minLength: 0)
                Text(article.publisherDate?.getStringFormattedDate() ?? "")
                    .font(.caption)
                    .foregroundStyle(Color.black)
                    .padding(.bottom, 12)
                Image(systemName: self.isFavorite ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .frame(width: 16, height: 20)
                    .foregroundStyle(self.isFavorite ? Color.orange : Color.gray)
                    .padding([.trailing, .bottom], 10)
                    .onTapGesture {
                        if self.isFavorite {
                            self.isFavorite = false
                            modelContext.delete(article)
                        } else {
                            self.isFavorite = true
                            modelContext.insert(article)
                        }
                    }
                
            }
        }
    }
}
