//
//  SplashViewController.swift
//  Spotify
//
//  Created by Poorav Lukhi on 07/12/24.
//

import UIKit

import UIKit

class SplashViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the navigation bar when the SplashViewController is displayed
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Start the navigation process
        navigateToDashboard()
    }
    
    /// Navigates to the DashboardTabBarController
    func navigateToDashboard() {
        // Load the DashboardTabBarController from the storyboard
        
        if let dashboardTabBarController = loadViewController(Storyboard: Storyboards.Dashboard, ViewController: ViewControllers.DashboardTabBarController) as? DashboardTabBarController {
            
            // Push the DashboardTabBarController to the navigation stack
            self.navigationController?.pushViewController(dashboardTabBarController, animated: true)
        }
    }
    
}
