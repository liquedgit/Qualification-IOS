//
//  EmployeeCellTableViewCell.swift
//  QualificationML
//
//  Created by prk on 23/08/23.
//

import UIKit

class EmployeeCellTableViewCell: UITableViewCell {
    
    var deleteHandler = {
        
    }
    
    var updateHandler = {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected){
            updateHandler();
        }
        // Configure the view for the selected state
    }

    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var WageYLabel: UILabel!
    
    @IBOutlet weak var DivisionLabel: UILabel!
    
    
    @IBAction func DeleteBtnOnClick(_ sender: Any) {
        deleteHandler();
    }
    
}
