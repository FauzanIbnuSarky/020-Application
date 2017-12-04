//
//  KaryawanTableViewCell.swift
//  Data Karyawan
//
//  Created by muqorrobin aimar on 11/17/17.
//  Copyright © 2017 muqorrobin aimar. All rights reserved.
//

import UIKit

class KaryawanTableViewCell: UITableViewCell {
    @IBOutlet weak var lblNama: UILabel!
    @IBOutlet weak var lblPosisi: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
