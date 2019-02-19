//
//  SofteamView.swift
//  SofteamQuiz
//
//  Created by hero on 18/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class SofteamView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 7.0
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
    
}
