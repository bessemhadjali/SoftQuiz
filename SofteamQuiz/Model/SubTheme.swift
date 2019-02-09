//
//  SousTheme.swift
//  SofteamQuiz
//
//  Created by Guest User on 03/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation

struct SubTheme {
    let id: Int
    let title: String
    let questions: [Question]
    
    init(id: Int, title: String, questions: [Question]) {
        self.id = id
        self.title = title
        self.questions = questions
    }
}
