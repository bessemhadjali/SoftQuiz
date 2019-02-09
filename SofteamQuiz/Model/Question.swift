//
//  Question.swift
//  SofteamQuiz
//
//  Created by Guest User on 03/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation

class Question {
    let id: Int
    let questionText: String
    let rule: String
    let options: [String]
    let correctAns: Int
    var wrongAns: Int
    var isAnswered: Bool
    
    init(id: Int, questionText: String, rule: String, options: [String], correctAns: Int, wrongAns: Int, isAnswered:Bool) {
        self.id = id
        self.questionText = questionText
        self.rule = rule
        self.options = options
        self.correctAns = correctAns
        self.wrongAns = wrongAns
        self.isAnswered = isAnswered
    }
}
