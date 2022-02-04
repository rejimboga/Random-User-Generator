//
//  UserCell.swift
//  Random User Generator
//
//  Created by Macbook Air on 24.01.2022.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupWith(user: UserModel) {
        guard let urlString = user.picture?.thumbnail else { return }
        let url = URL(string: urlString)
        avatarImage.layer.cornerRadius = 25
        avatarImage.sd_setImage(with: url, completed: nil)
        
        guard let userNameTitle = user.name?.title else { return }
        guard let userNameFirst = user.name?.first else { return }
        guard let userNameLast = user.name?.last else { return }
        userNameLabel.text = "\(userNameTitle) \(userNameFirst) \(userNameLast)"
        phoneNumberLabel.text = user.phone
    }
}
