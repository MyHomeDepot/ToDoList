//
//  TabBarController.swift
//  ToDoList
//
//  Created by LEO on 29.11.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setupTabBarAppearance()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: UINavigationController(rootViewController: TaskListViewController()),
                title: "Home",
                image: UIImage(systemName: "house.fill")
            ),
            generateVC(
                viewController: ProfileViewController(),
                title: "Profile",
                image: UIImage(systemName: "person.fill")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setupTabBarAppearance() {
        let tabBarBackView = UIView()
        tabBarBackView.backgroundColor = .white
        tabBarBackView.layer.cornerRadius = 15
        tabBarBackView.translatesAutoresizingMaskIntoConstraints = false
        
        tabBar.insertSubview(tabBarBackView, at: 0)
        
        NSLayoutConstraint.activate([
            tabBarBackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tabBarBackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tabBarBackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBarBackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        tabBar.tintColor = .darkGray
        tabBar.unselectedItemTintColor = .lightGray
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabBarView = tabBar.superview else { return }
        
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.4
        tabBarView.layer.add(transition, forKey: nil)
    }
    
}
