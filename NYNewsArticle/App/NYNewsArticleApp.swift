//
//  NYNewsArticleApp.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 24/08/25.
//

import SwiftUI

@main
struct NYNewsArticleApp: App {
    
    @StateObject var coordinator: AppCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
