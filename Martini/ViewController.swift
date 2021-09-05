//
//  ViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/16.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AuthController.shared.login(email: "glflakcm@hanmail.com", password: "123456") 
        self.view.tintColor = .systemRed
        let viewControllers:[UIViewController] = [
            initTabViewController("MainView", identfire: "MainVC", title: "칵테일추천", icon: UIImage(systemName: "hand.thumbsup"), tag: 1),
            initTabViewController("Search", identfire: "SearchVC", title: "칵테일찾기", icon: UIImage(systemName: "magnifyingglass"), tag: 2),
            initTabViewController("FindView", identfire: "FindView", title: "조건검색", icon: UIImage(systemName: "plus.magnifyingglass"), tag: 3),
            initTabViewController("SettingView", identfire: "SettingView", title: "설정", icon: UIImage(systemName: "person"), tag: 4)
        ]
        
        self.setViewControllers(viewControllers, animated: false)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if AuthController.shared.userSession == nil {
            let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        
    }

}

extension UITabBarController {
    
    func initTabViewController(_ bundleName: String, identfire: String, title: String, icon: UIImage?, tag: Int) -> UIViewController{
        let vc = UIStoryboard(name: bundleName, bundle: nil).instantiateViewController(withIdentifier: identfire)
        vc.tabBarItem = UITabBarItem(title: title, image: icon, tag: tag)
        return vc
    }
    
}
