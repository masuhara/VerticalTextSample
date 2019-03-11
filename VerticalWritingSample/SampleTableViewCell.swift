//
//  SampleTableViewCell.swift
//  VerticalWritingSample
//
//  Created by Masuhara on 2019/03/09.
//  Copyright © 2019 Ylab.inc. All rights reserved.
//

import UIKit

class SampleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var verticalLabel: VerticalWritingLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .clear
        self.isOpaque = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
