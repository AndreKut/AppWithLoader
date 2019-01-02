//
//  CustomCollectionViewCell.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

import UIKit

protocol CollectionCellDelegate: class {
    func addToCollection()
    func selectLikeButton()
}

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var centralImage: UIImageView!
    @IBOutlet private weak var userIconImage: UIImageView!
    @IBOutlet private weak var userNameTitle: UILabel!
    @IBOutlet private weak var likesButton: UIButton!

    private var viewModel: CollectionCellViewModel?

    var delegate: CollectionCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        likesButton.isSelected = viewModel?.isLikedByUser ?? false
    }

    func setupUI(from viewModel: CollectionCellViewModel) {
        
        self.viewModel = viewModel

        viewModel.userIconUpdate = { [weak self] in
            self?.userIconImage.image = viewModel.userIconImage
        }
        viewModel.centralImageUpdate = { [weak self] in
            self?.centralImage.image = viewModel.centralImage
        }

        self.userNameTitle.text = viewModel.userName
        self.likesButton.setTitle("\(viewModel.likesCount)", for: .normal)
    }

    @IBAction func likeButton(_ sender: UIButton) {
        delegate?.selectLikeButton()
        guard let model = viewModel else { return }
        likesButton.isSelected = !model.isLikedByUser
    }

    @IBAction func collectButton(_ sender: UIButton) {
        delegate?.addToCollection()
    }
}
