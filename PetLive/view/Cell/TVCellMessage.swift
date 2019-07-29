//
//  StoreTrackTableViewCell.swift
//  Top25
//
//  Created by Tom Harrington on 8/2/16.
//  Copyright © 2016 Atomic Bird. All rights reserved.
//

import UIKit

class TVCellMessage: UITableViewCell {
    @IBOutlet weak var lblMessageTitle: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var txtDoctorAnswer: UITextField!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblPostDate: UILabel!
    @IBOutlet weak var VExpandedCell: UIView! {
        didSet {
            VExpandedCell.isHidden = true
        }
    }
    @IBOutlet weak var VDoctorReplayCell: UIView!{
        didSet {
            VDoctorReplayCell.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnSaveAnswer(_ sender: Any) {
        
        lblAnswer.text = txtDoctorAnswer.text!
        txtDoctorAnswer.text = ""
    }
    

}
