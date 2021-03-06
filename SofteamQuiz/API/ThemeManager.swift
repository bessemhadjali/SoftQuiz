//
//  QuestionManager.swift
//  SofteamQuiz
//
//  Created by Guest User on 03/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import Foundation

final class ThemeManager {
    
    private var themes = [Theme]()
    
    init() {
        // Les règles d'utilisation relatives à la confidentialité des informations clients, à la sécurité des ressources informatiques et des moyens de communication électronique s'appliquent à TOUT MOMENT : avant mission, durant la mission et après la mission
        let question1 = Question(id: 1, questionText: "Question_1 : Un document du client obtenu pendant votre mission ne doit pas être divulgué à l'extérieur du client même après la fin de mission", rule: "Les règles d'utilisation relatives à la confidentialité des informations clients, à la sécurité des ressources informatiques et des moyens de communication électronique s'appliquent à TOUT MOMENT : avant mission, durant la mission et après la mission", comment: "en effet, tout document client ne doit pas être communiqué, ni diffusé à l’extérieur du client, ce à aucun moment.il doit néanmoins être restitué au client à la fin de la mission", options: ["VRAIX", "FAUX", "Cela dépend du contenu du document", "La question ne se pose pas car après la fin de la mission le consultant ne doit plus être en possession du document."], correctAns: 4, wrongAns: -1, isAnswered: false)
        let question2 = Question(id: 1, questionText: "Question_2 : Les régles concernant la sécurité et les performances du système du client …", rule: "Les règles de sécurité et de performances des ressources informatiques s'appliquent aussi bien aux outils informatiques, qu'aux moyens de communication électronique du client ", comment: "le niveau de criticité opérationnelle n'empêche pas de contenir des informations confidentielles : c'est pourquoi les règles de sécurité s'appliquent aussi aux systèmes peu critiques", options: ["Dépendent du niveau de criticité opérationnelle du système", "Dépendent du niveau de confidentialité du système", "Dépendent à la fois du niveau de criticité opérationnelle et de confidentialité du système", "S'appliquent indistinctement à tous les systèmes du client"], correctAns: 4, wrongAns: -1, isAnswered: false)
        //        let question2 = Question(id: 2, questionText: "q2", rule: "r3", options: ["a", "b", "c", "d"], correctAns: 1, wrongAns: -1, isAnswered: false)
        let question3 = Question(id: 3, questionText: "q3", rule: "r3", comment: "c3", options: ["a", "b"], correctAns: 1, wrongAns: -1, isAnswered: false)
        let question4 = Question(id: 4, questionText: "q4", rule: "r4", comment: "c4", options: ["a", "b", "c", "d"], correctAns: 4, wrongAns: -1, isAnswered: false)
        let question5 = Question(id: 5, questionText: "q5", rule: "r5", comment: "c5", options: ["a", "b", "c", "d"], correctAns: 1, wrongAns: -1, isAnswered: false)
        let question6 = Question(id: 6, questionText: "q6", rule: "r6", comment: "c6", options: ["a", "b", "c", "d"], correctAns: 3, wrongAns: -1, isAnswered: false)
        let question7 = Question(id: 7, questionText: "q7", rule: "r7", comment: "c7", options: ["a", "b", "c"], correctAns: 2, wrongAns: -1, isAnswered: false)
        
        let subTheme1 = SubTheme(id: 1, title: "Champ d'application : Qui est concerné, Quand s'appliquent les règles, et qu'est-ce qui est couvert", questions: [question1, question2, question3])
        let subTheme2 = SubTheme(id: 1, title: "ST2", questions: [question4, question5])
        let subTheme3 = SubTheme(id: 1, title: "ST3", questions: [question6, question7])
        
        let theme1 = Theme(id: 1, title: "Règles d'utilisation et d'engagement relatives à la confidentialité, aux outils informatiques et moyens de communication électronique", score: 10, subThemes: [subTheme1, subTheme2])
        let theme2 = Theme(id: 1, title: "T2", score: 11, subThemes: [subTheme3])
        
        themes = [theme1, theme2]
        
    }
    
    func getAllThemes() -> [Theme] {
        return themes
    }
}
