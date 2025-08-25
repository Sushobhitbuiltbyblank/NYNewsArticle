//
//  NYNewsArticleApp.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 24/08/25.
//

import SwiftUI

@main
struct NYNewsArticleApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView() // default DI
        }
    }
}
