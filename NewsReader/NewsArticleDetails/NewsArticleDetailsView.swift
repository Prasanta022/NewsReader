//
//  NewsArticleDetailsView.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftData

struct NewsArticleDetailsView: View {
    
    let article: Article
    let storedArticles: [Article]
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.modelContext) private var modelContext
    @State var isFavorite: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                GeometryReader { geometry in
                    ZStack {
                        imageView(geometry: geometry)
                            .overlay {
                                VStack {
                                    navigationBackAndFabButoonView
                                    Spacer()
                                }
                            }
                    }
                }
                .frame(height: 290)
                VStack(alignment: .leading) {
                    articleInfoView
                }
            }
            
        }
        .onAppear {
            self.isFavorite = storedArticles.contains(where: { $0.id == article.id })
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.white)
        .navigationBarHidden(true)
    }
}

extension NewsArticleDetailsView {
    
    private func imageView(geometry: GeometryProxy) -> some View {
        Group {
            if geometry.frame(in: .global).minY <= 0 {
                WebImage(url: URL(string: article.media?.first?.mediaMetadata?.last?.url ?? "")) { image in
                    image.image?.resizable()
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(y: geometry.frame(in: .global).minY/9)
                .clipped()
            } else {
                WebImage(url: URL(string: article.media?.first?.mediaMetadata?.last?.url ?? "")) { image in
                    image.image?.resizable()
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                .clipped()
                .offset(y: -geometry.frame(in: .global).minY)
            }
        }
    }
    
    private var navigationBackAndFabButoonView: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color.black)
                    .frame(width: 30, height: 30)
                    .background(Color.white)
                    .clipShape(Circle())
            }
            Spacer(minLength: 10)
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: self.isFavorite ? "bookmark.fill" : "bookmark")
                    .frame(width: 30, height: 30)
                    .foregroundStyle(self.isFavorite ? Color.orange : Color.gray)
                    .background(Color.white)
                    .clipShape(Circle())

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
        }.padding(.horizontal, 10)
    }
    
    private var articleInfoView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(article.title ?? "")
                    .font(.headline)
                    .foregroundStyle(Color.black)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 0)
            }
            HStack {
                Text(article.author ?? "")
                    .font(.caption)
                    .foregroundStyle(Color.black)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 0)
            }
            HStack {
                Spacer(minLength: 0)
                Text(article.publisherDate?.getStringFormattedDate() ?? "")
                    .font(.caption)
                    .foregroundStyle(Color.black)
            }
        }
        .padding([.horizontal, .top], 10)
    }
}
