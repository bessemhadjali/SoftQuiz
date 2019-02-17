//
//  SelfSizedTableView.swift
//  SofteamQuiz
//
//  Created by hero on 16/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.isScrollEnabled = false
        //heightConstraint.constant = tableView.contentSize.height
        //    UIView.animate(withDuration: 0.2) {
        //      self.layoutIfNeeded()
        //    }
        
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}
