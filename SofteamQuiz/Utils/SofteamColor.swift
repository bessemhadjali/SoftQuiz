//
//  Color.swift
//  SofteamQuiz
//
//  Created by hero on 18/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

enum SofteamColor {
    
    case Success
    case Failed
    
    private var rgbValue: UInt {
        switch self {
        case .Success: return 0x22B573
        case .Failed: return 0xC1272D
        }
    }
    public func UIColorFromRGB() -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

