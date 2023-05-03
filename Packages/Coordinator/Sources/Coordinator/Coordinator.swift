import UIKit

/// Represents the coordination type
public enum CoordinationTypes {
    case navigation
    case segue
}


open class Coordinator: NSObject {
    
    /// Navigation controller to push and present view controllers
    public private(set) var navigationController: UINavigationController
    
    /// Index of the current view controller in the viewControllers array
    public private(set) var currentIndex: Int = -1

    /// Array of ViewControllers
    public private(set) var viewControllers: [CoordinatorViewController.Type]  = []
    
    /// Initialize the navigation controller
    public override init() {
        navigationController = .init(nibName: nil, bundle: nil)
        super.init()
        
    }
    
    /// Method to navigate forward to the next view controller
    open func push(userInfo: [String: Any]? = nil ) {
        
        // Check if the current index is less than the last index in the viewControllers array
        guard currentIndex <= viewControllers.count - 1 else { return }
        
        increaseCurrentIndex()
        
        let currentCoordinator = self.viewControllers[currentIndex]
        self.push(to: currentCoordinator, userInfo: userInfo)
        
    }
        
    /// Method to navigate forward to the given view controller
    open func push(to viewController: CoordinatorViewController.Type, userInfo: [String: Any]? = nil ) {
        
        // Instantiate the current view controller
        let currentViewController = viewController.init()
        
        // Set the coordinator and user info properties of the view controller
        currentViewController.coordinator = self
        currentViewController.userInfo = userInfo
        
        // Push or present the view controller depending on its coordination type
        switch currentViewController.coordinationType {
            
        case .navigation:
            
            navigationController.pushViewController(currentViewController, animated: true)
            
        case .segue:
            
            // Ensure that the current index is greater than 0 to avoid presenting a segue on the first view controller
            if currentIndex <= -1{
                fatalError("you should not present segue at first ViewController at coordinator array")
            }
            guard let lastVC = navigationController.viewControllers.last as? CoordinatorViewController else {return}
            lastVC.presentViewController(currentViewController)
            
        }
    }
    
    /// Method to navigate backward to the previous view controller
    open func pop() {
        
        // Check if the current index is greater than 0
        guard currentIndex > 0 else { return }
        // Decrement the current index
        decreaseCurrentIndex()
        
    }

    /// Method to set the viewControllers array
    public func setViewControllers(_ viewControllers: [CoordinatorViewController.Type]) {
        self.viewControllers = viewControllers
        self.push()
    }
    
    private func increaseCurrentIndex() {
         self.currentIndex = currentIndex == viewControllers.count - 1 ? currentIndex : currentIndex + 1
     }
     
     private func decreaseCurrentIndex() {
         currentIndex -= 1
     }

  
    
}
