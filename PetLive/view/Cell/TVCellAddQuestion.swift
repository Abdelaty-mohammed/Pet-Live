//
//  TVCellAddQuestion.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/26/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import UIKit

class TVCellAddQuestion: UITableViewCell {
    @IBOutlet weak var TxVQuestion: UITextView!

    @IBOutlet weak var VAddQuestion: UIView!{
        didSet {VAddQuestion.isHidden = true}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnSendQuestion(_ sender: Any) {
        
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        VAddQuestion.isHidden = false
    }
    
}

