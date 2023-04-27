# Coordinator

The way I follow to implement Coordinator Design Pattern.

### Why using Coordinator design pattern?
Using the coordinator pattern in iOS apps lets us remove the job of app navigation from our view controllers, helping make them more manageable and more reusable, while also letting us adjust our app's flow whenever we need.

### How to use This?
Add to your project using Swift Package Manager

```
https://github.com/ahmed-yamany/Coordinator
```
create a class that Inherets from The Coordinator Class

```swift
import Coordinator

class AuthCoordinator: Coordinator {
    
    override init() {
        super.init()
        // arrray of viewControllers that inherets from CoordinatorViewController
        super.viewControllers = [EmailViewController.self, PasswordViewController.self,
                                UserInforViewController.self]
        super.push()
        
    }
}
```
```swift
class EmailViewController: CoordinatorViewController {
    
    ...
    ...

    @IBAction func buttonTapped(_ sender: UIButton) {
        self.coordinator?.push()
    }
    
    
}
```

In the SceneDelegate you can do this
```swift
 func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = AuthCoordinator().navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
```



