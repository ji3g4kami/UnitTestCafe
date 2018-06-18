//
//  TabBarViewController.swift
//  UnitTestCafe
//
//  Created by 吳登秝 on 2018/6/18.
//  Copyright © 2018年 DavidWu. All rights reserved.
//

import UIKit

enum TabBar {
    
    case order
    
    case list
    
    func controller() -> UIViewController {
        
        switch self {
            
        case .order:
            return UIStoryboard.orderStoryboard().instantiateInitialViewController()!
            
        case .list:
            return UIStoryboard.listStoryboard().instantiateInitialViewController()!
        }
    }
    
    func image() -> UIImage {
        
        switch self {
            
        case .order:
            return #imageLiteral(resourceName: "add-shopping-cart")

        case .list:
            return #imageLiteral(resourceName: "clipboard")
        }
    }
    
    func title() -> String {
        switch self {
            
        case .order:
            return "order"
            
        case .list:
            return "list"
        }
    }
    
    func selectedImage() -> UIImage {
        
        switch self {
            
        case .order:
            return #imageLiteral(resourceName: "add-shopping-cart").withRenderingMode(.alwaysTemplate)
            
        case .list:
            return #imageLiteral(resourceName: "clipboard").withRenderingMode(.alwaysTemplate)
        }
    }
}

class TabBarViewController: UITabBarController {
    
    var tabs: [TabBar] = [.order, .list]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
        setItemColor()
    }
    
    private func setItemColor() {
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    private func setupTab() {
        
        var controllers: [UIViewController] = []
        
        for tab in tabs {
            
            let controller = tab.controller()
            
            let item = UITabBarItem(
                title: tab.title(),
                image: tab.image(),
                selectedImage: tab.selectedImage()
            )
            
            item.imageInsets = UIEdgeInsets(top: -4, left: 0, bottom: 0, right: 0)
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
            
            controller.tabBarItem = item
            
            controllers.append(controller)
        }
        
        setViewControllers(controllers, animated: false)
    }
    
}

extension UIStoryboard {
    
    static func orderStoryboard() -> UIStoryboard {
        
        return UIStoryboard(name: "Order", bundle: nil)
    }
    
    static func listStoryboard() -> UIStoryboard {
        
        return UIStoryboard(name: "List", bundle: nil)
    }
}
