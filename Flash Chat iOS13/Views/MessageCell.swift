//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Mohamed Jaber on 11/29/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var labelFromXib: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    override func awakeFromNib() {//samiliar like view.load
        super.awakeFromNib()
        messageBubble.layer.cornerRadius=messageBubble.frame.size.height/5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
