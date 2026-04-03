//
//  ViewController.swift
//  Claquette
//
//  Created by Artur Bruno on 01/04/26.
//

import UIKit

class TabViewController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)

        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .systemBackground
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: nil)

        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .systemBackground
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)

        // Optionally wrap in navigation controllers
        viewControllers = [homeVC, searchVC]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        tabBar.tintColor = .accent
    }
    
}

