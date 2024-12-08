//
//  DashboardTabBarController.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import UIKit

class DashboardTabBarController: UITabBarController {
    //MARK: - Outlets
    
    ///Tab Bar
    @IBOutlet weak var bottomTabBar: UITabBar!
    
    var selectedMenuNo = 2

    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the unselected item tint color for the tab bar
        self.tabBar.unselectedItemTintColor = Colors.CustomGray
        
        // Configure the tab bar items
        configureTabBarItems()
    }
    
    
    /// Configures the items of the tab bar with custom images, titles, and styles
    private func configureTabBarItems() {
        guard let tabBarItems = self.tabBar.items else {
            print("Error: Tab bar items are not set.")
            return
        }
        
        // Configure Home tab item
        if tabBarItems.indices.contains(0) {
            let homeTabBarItem = tabBarItems[0]
            homeTabBarItem.image = AppImageName.ic_home?.withRenderingMode(.alwaysOriginal)
            homeTabBarItem.selectedImage = AppImageName.ic_home_selected?.withRenderingMode(.alwaysOriginal)
            homeTabBarItem.title = Localization.Dashboard.Home.title
            homeTabBarItem.imageInsets = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
            homeTabBarItem.setTitleTextAttributes([
                .font: UIFont(name: Font.AppSemiBold, size: FontSize.title)!,
                .foregroundColor: Colors.White
            ], for: .selected)
        }
        
        // Configure Search tab item
        if tabBarItems.indices.contains(1) {
            let searchTabBarItem = tabBarItems[1]
            searchTabBarItem.image = AppImageName.ic_search?.withRenderingMode(.alwaysOriginal)
            searchTabBarItem.selectedImage = AppImageName.ic_search_selected?.withRenderingMode(.alwaysOriginal)
            searchTabBarItem.title = Localization.Dashboard.Search.title
            searchTabBarItem.imageInsets = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
            searchTabBarItem.setTitleTextAttributes([
                .font: UIFont(name: Font.AppSemiBold, size: FontSize.title)!,
                .foregroundColor: Colors.White
            ], for: .selected)
        }
        
        // Configure Library tab item
        if tabBarItems.indices.contains(2) {
            let libraryTabBarItem = tabBarItems[2]
            libraryTabBarItem.image = AppImageName.ic_library?.withRenderingMode(.alwaysOriginal)
            libraryTabBarItem.selectedImage = AppImageName.ic_library_selected?.withRenderingMode(.alwaysOriginal)
            libraryTabBarItem.title = Localization.Dashboard.Library.title
            libraryTabBarItem.imageInsets = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
            libraryTabBarItem.setTitleTextAttributes([
                .font: UIFont(name: Font.AppSemiBold, size: FontSize.title)!,
                .foregroundColor: Colors.White
            ], for: .selected)
        }
        
        //MARK:- if you are in UITabBarController
        DispatchQueue.main.async {
            self.selectedIndex = self.selectedMenuNo
        }
    }
}
