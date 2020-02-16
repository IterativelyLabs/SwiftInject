# SwiftInject

[![Build Status](https://travis-ci.com/IterativelyLabs/BitriseApiSwift.svg?branch=master)](https://travis-ci.com/IterativelyLabs/BitriseApiSwift)

#### Initialising 

```swift
let dependencyInjectManager = SwiftInjectManager()
```
Create this at the highest scope possible (i.e. inside `AppDelegate` for iOS apps, inside `main.swift` for command line apps).

This will perform a search for any and all modules that have been defined and populate the default container.

#### Defining a module
```swift
class MyModule: SwiftInjectModule {

   override func setUp() {

       container.register(UserInfoProvider.self, mode: .useContainer) { resolver in
           let nameFormatter = resolver.resolve(MyNameFormatter.self)!
           let dateFormatter = resolver.resolve(MyDateFormatter.self)!
           return UserInfoProvider(nameFormatter, dateFormatter: dateFormatter)
       }

       container.register(NameProvider.self, mode: .useContainer) { resolver in
           let titleProvider = resolver.resolve(TitleProvider.self)!
           return NameProvider(titleProvider) 
       }

       container.register(MyDateFormatter.self, mode: .useContainer) { resolver in
           return MyDateFormatter("dd/mmy/yyyy")
       }

       container.register(TitleProvider.self, mode: .useContainer) { resolver in
           return TitleProvider()
       }
   }
}
```

#### @Inject

Marking any properties with `@Inject` will cause the value to be lazy obtained from the container on first access.

```swift
class UserInfoViewController: UIViewController {

    @Inject private var userInfoProvider: UserInfoProvider!
    
    let user: User

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userNameLabel.text = userInfoProvider.formatName(user)        
        userDOBLabel.text = userInfoProvider.formatDOB(user)
    }
}
```

#### Using the container directly

If using `@Inject` isn't appropriate or you only need things from the container in a reduce scope, you can resolve them directly from the container.

```swift
class UserInfoViewController: UIViewController {

    let user: User

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userInfoProvider = SwiftInjectContainer.default.resolve(UserInfoProvider.self)!
        
        userNameLabel.text = userInfoProvider.formatName(user)        
        userDOBLabel.text = userInfoProvider.formatDOB(user)
    }
}
```
