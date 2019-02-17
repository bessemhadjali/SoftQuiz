//
//  ResponseOptionCell.swift
//  SofteamQuiz
//
//  Created by hero on 16/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class ResponseOptionCell: UITableViewCell {

    @IBOutlet weak var optionText: UILabel!
    @IBOutlet weak var optionContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.optionContainer.backgroundColor = UIColor.white
        self.optionContainer.layer.cornerRadius = 7.0
        self.optionContainer.layer.borderWidth = 1.0
        self.optionContainer.layer.borderColor = UIColor.black.cgColor
        self.optionContainer.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
