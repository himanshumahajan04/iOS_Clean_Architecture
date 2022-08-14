//
//  PostTableViewCell.swift
//  TestDemo
//
//  Created by Himanshu Mahajan on 14/08/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
        
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblBody: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(viewModel: PostCellViewModel) {
        lblTitle.text = viewModel.title
        lblBody.text = viewModel.body
    }
}

