//
//  FollowersCell.swift
//  GithubFollowers
//
//  Created by Israkul Tushaer-81 on 22/1/24.
//

import UIKit
import SDWebImage
class FollowersCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var followersTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure( item : Followers ){
        self.followersTitle.text = item.login
        guard let imageURl = item.avatar_url else { return }
        print(imageURl)
        self.iconImageView.sd_setImage(with: URL(string: imageURl), placeholderImage:UIImage(named: "avatar-placeholder"))
    }
}
