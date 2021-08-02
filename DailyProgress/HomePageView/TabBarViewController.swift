//
//  TabBarViewController.swift
//  DailyProgress
//
//  Created by 陳郁勳 on 2021/7/20.
//

import UIKit

class TabBarViewController: UITabBarController
{
    let customButton = UIButton()
    let homeVc = HomePageViewController(viewType: .undone)
    let profileVC = HomePageViewController(viewType: .done)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let viewControllers = [homeVc, profileVC]
        homeVc.title = "未完成項目"
        profileVC.title = "已完成項目"
        homeVc.navigationItem.largeTitleDisplayMode = .always
        profileVC.navigationItem.largeTitleDisplayMode = .always
        homeVc.tabBarItem.image = UIImage(systemName: "house")
        profileVC.tabBarItem.image = UIImage(systemName: "flag")
        
        let nav1 = UINavigationController(rootViewController: viewControllers[0])
        let nav2 = UINavigationController(rootViewController: viewControllers[1])
        setViewControllers([nav1, nav2], animated: true)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        nav1.navigationBar.barTintColor = UIColor.tabBarButtonColor
        nav2.navigationBar.barTintColor = UIColor.tabBarButtonColor
        
        guard let font = UIFont(name: "kefa", size: 40) else { return }
        nav1.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.navigationBarTintColor, .font: font]
        nav2.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.navigationBarTintColor, .font: font]
        nav1.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav2.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        tabBar.barTintColor = UIColor.defaultBackgroundColor
        tabBar.isTranslucent = true
        tabBar.tintColor = UIColor.tabBarButtonColor
        tabBar.unselectedItemTintColor = UIColor.tabBarButtonColor
        UITabBar.appearance().tintColor = UIColor.navigationBarTintColor
        settingButton()
    }
    
    @objc func addDailyProgress()
    {
        let vc = AddDailyScheduleViewController()
        vc.addDailyScheduleDelegate = self.homeVc
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    func settingButton()
    {
        let config = UIImage.SymbolConfiguration(pointSize: 43, weight: .medium, scale: .default)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        self.customButton.setImage(image, for: .normal)
        self.customButton.tintColor = UIColor.tabBarButtonColor
        self.customButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        self.customButton.layer.cornerRadius = 30
        self.customButton.layer.borderWidth = 3
        self.customButton.layer.borderColor = UIColor.cycleBackgroundColor().cgColor
        self.customButton.clipsToBounds = true
        self.customButton.addTarget(self, action: #selector(addDailyProgress), for: .touchUpInside)
        self.view.addSubview(self.customButton)
        customButton.snp.makeConstraints
        { (make) in
            make.centerX.equalTo(tabBar)
            make.centerY.equalTo(tabBar.snp.top)
            make.width.height.equalTo(60)
        }
    }
}
