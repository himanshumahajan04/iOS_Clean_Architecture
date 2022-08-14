//
//  PostListViewController.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import UIKit

class PostListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: IPostViewModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchPosts()
    }
}

extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCellIdentifier", for: indexPath) as? PostTableViewCell else {
            fatalError()
        }

        cell.configure(viewModel: viewModel.posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}


extension PostListViewController: PostViewModelOutput {
    
    func handleSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func handleFailure(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: NSLocalizedString("alert", comment: ""), message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}




