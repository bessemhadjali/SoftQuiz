//
//  Theme.swift
//  SofteamQuiz
//
//  Created by Guest User on 03/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation

struct Theme {
    let id: Int
    let title: String
    let score: Int
    let subThemes: [SubTheme]
    
    init(id: Int, title: String, score: Int, subThemes: [SubTheme]) {
        self.id = id
        self.title = title
        self.score = score
        self.subThemes = subThemes
    }
}
