//
//  RootCoordinator.swift
//  NYNewsArticle
//
//  Created by Sushobhit Jain on 25/08/25.
//

import SwiftUI
import Combine

// Route is value-based and Hashable → safer than pushing raw models
enum Route: Hashable {
    case detail(Article)
}

