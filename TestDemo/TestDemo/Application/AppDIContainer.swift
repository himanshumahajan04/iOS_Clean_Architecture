//
//  AppDIContainer.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import UIKit

class AppDIContainer {
    
    var networkManager: INetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    func load(on window: UIWindow?) {
        let module = PostModule(networkManager: networkManager)
        let viewController = module.generateViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
