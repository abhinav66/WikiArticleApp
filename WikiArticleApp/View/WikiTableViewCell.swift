//
//  WikiTableViewCell.swift
//  WikiArticleApp
//
//  Created by Abhinav Singh on 8/28/18.
//  Copyright © 2018 Abhinav. All rights reserved.
//

import UIKit

class WikiTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
