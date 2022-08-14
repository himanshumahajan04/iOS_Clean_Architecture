//
//  PostModule.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import Foundation
import UIKit

class PostModule {

    enum Constants {
        static let identifier = "PostListViewControllerIdentifier"
    }
    
    private let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }

    func generateViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Constants.identifier) as? PostListViewController  else {
            fatalError()
        }
        viewController.viewModel = generatePostViewModel()
        viewController.viewModel.outputDelegate = viewController
        return viewController
    }
    
    private func generatePostViewModel() -> IPostViewModel {
        let viewModel = PostViewModelImpl(useCase: generatePostUseCase())
        return viewModel
    }
    
    private func generatePostUseCase() -> IPostUseCase {
        let useCase = PostUseCaseImpl(respository: generatePostRepository())
        return useCase
    }
    
    private func generatePostRepository() -> IPostRepository {
        let repository = PostRepositoryImpl(service: generatePostService())
        return repository
    }
    
    private func generatePostService() -> IPostService {
        let service = PostServiceImpl(networkManager: networkManager)
        return service
    }
}
