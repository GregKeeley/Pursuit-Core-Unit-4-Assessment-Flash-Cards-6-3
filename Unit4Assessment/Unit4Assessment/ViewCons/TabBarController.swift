//
//  TabBarController.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class TabBarController: UITabBarController {
    
    private var dataPersistence = DataPersistence<FlashCard>(filename: "FlashCards.plist")
    
    private lazy var flashCardVC: FlashCardsViewController = {
        let viewController = FlashCardsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Flash Cards", image: UIImage(systemName: "questionmark.circle"), tag: 0)
        viewController.dataPersistence = dataPersistence
        return viewController
    }()
    private lazy var addCardVC: AddCardViewController = {
        let viewController = AddCardViewController()
        viewController.tabBarItem = UITabBarItem(title: "Add Cards", image: UIImage(systemName: "plus"), tag: 1)
        viewController.dataPersistence = dataPersistence
        return viewController
    }()
    private lazy var searchVC: SearchViewController = {
        let viewController = SearchViewController()
        viewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        viewController.dataPersistence = dataPersistence
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: flashCardVC),UINavigationController(rootViewController: addCardVC),UINavigationController(rootViewController: searchVC)]
    }
    


}
