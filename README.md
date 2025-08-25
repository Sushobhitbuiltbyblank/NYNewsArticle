# NYNewsArticle

## Introduction
**NYNewsArticle** is a sample iOS application built with **SwiftUI** showcasing the [New York Times Most Popular Articles API](https://developer.nytimes.com/docs/most-popular-product/1/overview).  
The app fetches the most-viewed articles, displays them in a list, and shows detailed information when a user selects an article.  
This project demonstrates modern iOS engineering practices including clean architecture, coordinators, and Swift concurrency.

---

## Quick Start 🚀
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/NYNewsArticle.git
   cd NYNewsArticle
   ```
2. Open `NYNewsArticle.xcodeproj` or `NYNewsArticle.xcworkspace` in **Xcode**.
3. Add your [NYT API Key](https://developer.nytimes.com/) into **Resources/Config.plist**:
   ```xml
   <key>baseURL</key>
   <string>https://api.nytimes.com/svc/mostpopular/v2</string>
   <key>apiKey</key>
   <string>YOUR_API_KEY_HERE</string>
   <key>defaultSection</key>
   <string>all-sections</string>
   <key>defaultPeriod</key>
   <integer>7</integer>
   ```
4. Run the app on the simulator (⌘R).

### Example Screenshots
| Articles List | Article Detail |
|---------------|----------------|
| ![Articles List](docs/list.png) | ![Article Detail](docs/detail.png) |

> 💡 Replace `docs/list.png` and `docs/detail.png` with actual simulator screenshots from your project.

---

## Technologies Used
- **Swift 6 / SwiftUI**
- **Combine** for state publishing
- **Async/Await** for structured concurrency
- **Protocol-oriented networking** (`NetworkManaging`)
- **Coordinator pattern** for navigation
- **Dependency Injection**
- **XCTest** for unit & UI testing
- **Xcode code coverage** for measuring test completeness

---

## Architecture Overview
The project is structured using a **Coordinator + Clean Architecture** approach:

- **Coordinator Layer**  
  - `RootCoordinator` protocol provides navigation APIs  
  - `AppCoordinator` implements feature flow (list → detail)  

- **Presentation Layer**  
  - SwiftUI views (`ArticlesListView`, `ArticleDetailView`)  
  - ViewModels interact with use cases and expose state  

- **Domain Layer**  
  - Use cases (e.g., `FetchMostViewedUseCase`)  
  - Models (`Article`, `Media`, `MediaMeta`, etc.)  

- **Data Layer**  
  - `NetworkManager` implements `NetworkManaging` using `URLSession`  
  - `DefaultArticlesRepository` fetches and maps API data  

---

## Project Structure
```
NYNewsArticle/
├── App/
│   └── NYNewsArticleApp.swift        # Entry point
├── Coordinators/
│   ├── RootCoordinator.swift
│   └── AppCoordinator.swift
├── Features/
│   ├── ArticlesList/
│   │   ├── ArticlesListView.swift
│   │   └── ArticlesListViewModel.swift
│   └── ArticleDetail/
│       ├── ArticleDetailView.swift
│       └── ArticleDetailViewModel.swift
├── Core/
│   ├── Networking/
│   │   ├── APIRequest.swift
│   │   ├── NetworkManager.swift
│   │   └── NetworkError.swift
│   ├── Repository/
│   │   └── ArticlesRepository.swift
│   └── Models/
│       └── Article.swift
├── Resources/
│   └── Config.plist                  # API base URL & key
├── Tests/
│   ├── Unit/
│   │   ├── AppCoordinatorTests.swift
│   │   ├── RootCoordinatorTests.swift
│   │   ├── NetworkManagerTests.swift
│   │   └── ArticleDetailViewTests.swift
│   └── UITests/
│       └── NYNewsArticleUITests.swift
└── README.md
```

---

## Requirements
- macOS 14+
- Xcode 15+
- iOS 17+ (deployment target)
- Valid [NYT API Key](https://developer.nytimes.com/)

---

## Features
- ✅ Fetches most viewed articles from NYT API  
- ✅ Displays articles in a clean SwiftUI list  
- ✅ Tappable rows → Detail screen with full content  
- ✅ Async image loading with placeholder  
- ✅ Coordinator-based navigation  
- ✅ Error handling with user-friendly messages  
- ✅ Configurable base URL & API key  
- ✅ Comprehensive unit and UI tests  

---

## Testing

### Run Tests
In Xcode:  
1. Select **Product > Test** (⌘U)  
2. Or run specific tests from the **Test Navigator**

From command line:
```bash
xcodebuild   -scheme NYNewsArticle   -sdk iphonesimulator   -destination 'platform=iOS Simulator,name=iPhone 15'   clean test
```

### Generate Coverage Reports
1. In Xcode:  
   - Go to **Edit Scheme > Test > Options**  
   - Enable **Gather coverage for all targets**  
   - Run tests and open **Report Navigator → Coverage**  

2. From CLI (using `xcresulttool`):  
   ```bash
   xcodebuild      -scheme NYNewsArticle      -sdk iphonesimulator      -destination 'platform=iOS Simulator,name=iPhone 15'      -enableCodeCoverage YES      clean test

   # Export coverage
   xcrun xccov view --report --json      build/Logs/Test/*.xcresult > coverage.json
   ```
