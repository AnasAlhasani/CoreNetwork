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

**2. Controller:**

```swift
class BooksViewController: UIViewController {
    
    private lazy var apiClient: APIClient = {
        // Manual configurations
        let configurations = ServiceConfigurator(baseURL: "https://127.0.0.1/api")
        // Or use automatic configurations
        // let configurations = ServiceConfigurator()
        return DefaultAPIClient(configurations)
    }()
    
    private var books = [Book]()
    private var book: Book?
    
    func loadBooks() {
        let request = RequestBuilder<[Book]>()
            .path("books")
            .method(.get)
            .build()
        
        apiClient.execute(request) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case let .success(value):
                self.books = value
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addBook(parameters: AddBookParameters) {
        let request = RequestBuilder<Book>()
            .path("books")
            .method(.post)
            .encode(parameters, bodyEncoding: .jsonEncoding)
            .build()
        
        apiClient.execute(request) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case let .success(value):
                self.book = value
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteBook(_ book: Book) {
        let request = RequestBuilder<VoidResponse>()
            .path("books/\(book.id)")
            .method(.delete)
            .build()
        
        apiClient.execute(request) { (result) in
            switch result {
            case let .success(value):
                print(value)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
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
