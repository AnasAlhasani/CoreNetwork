# CoreNetwork

<p align="justify">
    <img src="https://img.shields.io/badge/Swift-4.2-orange.svg" />
    <img src="https://img.shields.io/badge/Platforms-iOS%20%7C%20watchOS-blue.svg?style=flat" />
    <img alt="GitHub tag (latest SemVer)" src="https://img.shields.io/github/tag/anasalhasani/corenetwork.svg">
    <a href="https://codebeat.co/projects/github-com-anasalhasani-corenetwork-master">
      <img src="https://codebeat.co/badges/e7169d1a-505e-49b8-ba1c-d140042e27d3" alt="Codebeat" />
    </a>
</p>

Protocol oriented networking layer on top of Alamofire

## Used Libraries

* [**Alamofire**](https://github.com/Alamofire/Alamofire): Elegant HTTP Networking in Swift.
* [**Google/Promises**](https://github.com/google/promises): a modern framework that provides a synchronization construct for Objective-C and Swift to facilitate writing asynchronous code.

## Examples

**1. Entities:**

* `Responses`

```swift
struct Book: Decodable {
    var id: String
    var title: String
    var author: String
    var releaseDate: Date?
    var pages: Int
}

struct VoidResponse: Decodable {
    // Some endpoints might return: 204 No Content
}
```

* `Parameters`

```swift
struct AddBookParameters: Encodable {
    var title: String
    var author: String
    var releaseDate: Date?
    var pages: Int
}
```

**2. UseCase:**

```swift
protocol BooksUseCase {
    func loadBooks() -> Promise<[Book]>
    func addBook(_ parameters: AddBookParameters) -> Promise<Book>
    func deleteBook(_ book: Book) -> Promise<VoidResponse>
}

final class APIBooksUseCase {
    
    private let apiClient: APIClient
    
    // Automatic configurations
    init(apiClient: APIClient = DefaultAPIClient()) {
        self.apiClient = apiClient
    }
}

extension APIBooksUseCase: BooksUseCase {
    func loadBooks() -> Promise<[Book]> {
        let request = RequestBuilder<[Book]>()
            .path("books")
            .method(.get)
            .build()
        
        return apiClient.execute(request)
    }
    
    func addBook(_ parameters: AddBookParameters) -> Promise<Book> {
        let request = RequestBuilder<Book>()
            .path("books")
            .method(.post)
            .encode(parameters, bodyEncoding: .jsonEncoding)
            .build()
        
        return apiClient.execute(request)
    }
    
    func deleteBook(_ book: Book) -> Promise<VoidResponse> {
        let request = RequestBuilder<VoidResponse>()
            .path("books/\(book.id)")
            .method(.delete)
            .build()
        
        return apiClient.execute(request)
    }
}
```
## Installation

To integrate CoreNetwork into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'CoreNetwork', :git => "https://github.com/AnasAlhasani/CoreNetwork"
```

Then, run the following command:

```bash
$ pod install
```

## Author

Anas Alhasani

[![Twitter Follow](https://img.shields.io/twitter/follow/AlhasaniAnas.svg?label=Anas%20Alhasani&style=social)](https://twitter.com/AlhasaniAnas)

[![GitHub Follow](https://img.shields.io/github/followers/AnasAlhasani.svg?style=social&label=Follow)](https://github.com/AnasAlhasani)
