//
//  CustomTabBarController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/02/2023.
//

import UIKit


class TabBar: UIView {
    // Properties to handle constraints for width and height of the tab bar
    private var widthConstraint: NSLayoutConstraint = .init()
    private var heightConstraint: NSLayoutConstraint = .init()
    
    // Property to handle size of tab bar
    var size: CGSize = .zero {
        didSet {
            // Remove previous constraints
            removeConstraint(widthConstraint)
            removeConstraint(heightConstraint)
            // Add new constraints for width and height
            widthConstraint = widthAnchor.constraint(equalToConstant: size.width)
            heightConstraint = heightAnchor.constraint(equalToConstant: size.height)
            // Activate constraints
            widthConstraint.isActive =  true
            heightConstraint.isActive = true
        }
    }

    init() {
        super.init(frame: .zero)
        // Enable clipping to bounds and Disable auto resizing mask into constraints
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomTabBarController: UIViewController {
    // MARK: - Properties
    //
    // Property to hold an array of view controllers
    var viewControllers: [UIViewController] = [] {
        didSet {
            // Loop through the view controllers
            for i in 0..<viewControllers.count {
                var configration = UIButton.Configuration.plain()
                configration.imagePlacement = .top
                let button = UIButton(configuration: configration)
                // Tag each button with its index
                button.tag = i
                // Add action to the button to handle tap events
                button.addTarget(self, action: #selector(self.tabBarItemTapped(_:)), for: .touchUpInside)
                // Add button to tab bar items stack view
                tabBarItemsStackView.addArrangedSubview(button)
            }
            // Set selectedIndex to 0 by default
            selectedIndex = 0
        }
    }
    
    // Property to handle selected index of tab bar
    var selectedIndex: Int = 0 {
        didSet {
            let selectedVC = self.viewControllers[self.selectedIndex]
            self.contentView.addSubview(selectedVC.view)
            selectedVC.didMove(toParent: self)
            self.customizeTabBarItem(at: selectedIndex)
        }
    }
    
    var tintColor: UIColor? = .label {
        didSet {
            self.customizeTabBarItem(at: selectedIndex)
        }
    }
    
    // MARK: - Views
    //
    // view that will hold the selected tab's view controller
    let contentView = UIView()
    
    var tabBar: TabBar = TabBar()
    
    var tabBarItemsStackView: UIStackView = {
        let stackview = UIStackView()
       stackview.axis = .horizontal
       stackview.distribution = .fillEqually
        stackview.translatesAutoresizingMaskIntoConstraints = false
       return stackview
   }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // DEFAULT screen width for width and 80 for height
        tabBar.size = CGSize(width: UIScreen.main.bounds.width, height: 80)
        tabBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // default size
        addContentView()

        view.addSubview(tabBar)
        layoutTabBar(tabBar)
        
        addTabBarItemsStackView()
    }
    
    private func addContentView() {
        view.addSubview(contentView)
        // fill to its super view
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func addTabBarItemsStackView() {
        tabBar.addSubview(tabBarItemsStackView)
        // fill to its super view
        tabBarItemsStackView.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        tabBarItemsStackView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        tabBarItemsStackView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor).isActive = true
        tabBarItemsStackView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor).isActive = true
    }
    
    private func customizeTabBarItem(at selectedIndex: Int){
        for i in 0...viewControllers.count-1 {
            let button = tabBarItemsStackView.arrangedSubviews[i] as! UIButton
            let vc = viewControllers[i]
            if selectedIndex == i {
                button.setImage(vc.tabBarItem.selectedImage, for: .normal)
            } else {
                button.setImage(vc.tabBarItem.image, for: .normal)
            }
            button.setTitle(vc.tabBarItem.title, for: .normal)
            button.tintColor = self.tintColor
        }

    }
  
    public func layoutTabBar(_ tabBar: TabBar){
        tabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func tabBarItemTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
}
