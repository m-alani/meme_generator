//
//  TableCustomCell.swift
//  Meme Generator
//
//  Created by Marwan Alani on 2017-03-07.
//  Copyright © 2017 Marwan Alani. All rights reserved.
//

import UIKit

class TableCustomCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTopLabel: UILabel!
    @IBOutlet weak var cellBottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
