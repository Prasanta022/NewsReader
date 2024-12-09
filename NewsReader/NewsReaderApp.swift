//
//  NewsReaderApp.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import SwiftUI
import SwiftData

@main
struct NewsReaderApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Article.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NewsListView(viewModel: NewsListViewModel())
        }
        .modelContainer(sharedModelContainer)
    }
}
