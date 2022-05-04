# ZemogaTest
**iOS** mobile application, which consumes [JSONplaceholder](https://jsonplaceholder.typicode.com/) **API** services as Test:
1. [Posts](https://jsonplaceholder.typicode.com/posts)
2. [Comments](https://jsonplaceholder.typicode.com/comments)
3. [Users](https://jsonplaceholder.typicode.com/users)

The App is following [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) pattern guidelines and has 2 screens:
1. A first screen to present a list of posts.
2. A second screen presents post details.

<img src="https://github.com/DennisMostajo/ZemogaTest/blob/main/posts.png" width="350"> <img src="https://github.com/DennisMostajo/ZemogaTest/blob/main/detail.png" width="350">
## How run this demo?
1. Clone this repo
2. Open shell window and navigate to project folder
3. Run `pod install` or `pod install --verbose`
4. Open `ZemogaTest.xcworkspace` and run the project
## Requirements:
- [XCode 13.0+](https://developer.apple.com/xcode)
- [Swift 5.0+](https://developer.apple.com/swift)
## Libraries with CocoaPods:
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [RealmSwift](https://github.com/realm/realm-swift)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [Toast-Swift](https://github.com/scalessec/Toast-Swift)
- [Reachability](https://github.com/tonymillion/Reachability)
