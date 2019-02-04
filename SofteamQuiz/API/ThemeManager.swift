//
//  QuestionManager.swift
//  SofteamQuiz
//
//  Created by Guest User on 03/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation

final class QuestionManager {
    
   private var themes = [Theme]()
    
    init() {
        let question1 = Question(id: 1, questionText: "aaaaa", rule: "ccccc", options: ["a", "b", "c", "d"], correctAns: 1, wrongAns: -1, isAnswered: false)
        let question2 = Question(id: 2, questionText: "aaaaa", rule: "ccccc", options: ["a", "b", "c", "d"], correctAns: 1, wrongAns: -1, isAnswered: false)
        let question3 = Question(id: 3, questionText: "aaaaa", rule: "ccccc", options: ["a", "b", "c", "d"], correctAns: 1, wrongAns: -1, isAnswered: false)
        let question4 = Question(id: 4, questionText: "aaaaa", rule: "ccccc", options: ["a", "b", "c", "d"], correctAns: 1, wrongAns: -1, isAnswered: false)
        let question5 = Question(id: 5, questionText: "aaaaa", rule: "ccccc", options: ["a", "b", "c", "d"], correctAns: 1, wrongAns: -1, isAnswered: false)
        let question6 = Question(id: 6, questionText: "aaaaa", rule: "ccccc", options: ["a", "b", "c", "d"], correctAns: 1, wrongAns: -1, isAnswered: false)
        let question7 = Question(id: 7, questionText: "aaaaa", rule: "ccccc", options: ["a", "b", "c", "d"], correctAns: 1, wrongAns: -1, isAnswered: false)
        
        let subTheme1 = SubTheme(id: 1, title: "", questions: [question1, question2, question3])
        let subTheme2 = SubTheme(id: 1, title: "", questions: [question4, question5])
        let subTheme3 = SubTheme(id: 1, title: "", questions: [question6, question7])
        
        
        let theme1 = Theme(id: 1, title: "", score: 0, subThemes: [subTheme1, subTheme2])
        let theme2 = Theme(id: 1, title: "", score: 0, subThemes: [subTheme3])
        
        themes = [theme1, theme2]
        
    }
    
    func getAllThemes() -> [Theme] {
        return themes
    }
}
