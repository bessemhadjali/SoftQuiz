//
//  QuizViewController.swift
//  SofteamQuiz
//
//  Created by Guest User on 03/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    var themeManager: ThemeManager?
    var allThemes = [Theme]()
    var currentQuestionNumber = 1
    var currentThemeNumber = 1
    var currentSubThemeNumber = 1
    @IBOutlet weak var subThemeLabel: UILabel!
    @IBOutlet weak var questionRuleLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeManager = ThemeManager.init()
        if let themeManager = themeManager {
            allThemes = themeManager.getAllThemes()
            updateQuestion()
        } else {
            return
        }
        
    }
    
    func restartQuiz(){
        currentQuestionNumber = 1
        currentThemeNumber = 1
        currentSubThemeNumber = 1
        
    }
    
    func updateQuestion(){
        print("question number = ", currentQuestionNumber)
        print("sub theme number = ", currentSubThemeNumber)
        print("theme number = ", currentThemeNumber)
        print("========================================== \n")
        self.title = allThemes[currentThemeNumber - 1].title
        subThemeLabel.text = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].title
        questionRuleLabel.text = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1].rule
        questionTextLabel.text = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1].questionText
    }
    
    @IBAction func nextQuestionAction(_ sender: Any) {

        let themesCount = allThemes.count
        let subThemeCount = allThemes[currentThemeNumber - 1].subThemes.count
        let questionCount = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions.count
        if currentQuestionNumber < questionCount {
            currentQuestionNumber += 1
        } else if currentSubThemeNumber < subThemeCount {
            currentSubThemeNumber += 1
            currentQuestionNumber = 1
        } else if  currentThemeNumber < themesCount{
            currentSubThemeNumber = 1
            currentQuestionNumber = 1
            currentThemeNumber += 1
        } else {
            print("fin fin")
            return
        }
        updateQuestion()
    }
    
    @IBAction func previousQuestion(_ sender: Any) {
        
        if currentQuestionNumber == 1 && currentSubThemeNumber == 1 && currentThemeNumber == 1 {
            print("debut")
            return
            
        } else if currentQuestionNumber == 1 && currentSubThemeNumber == 1  {
            currentThemeNumber -= 1
            currentSubThemeNumber = allThemes[currentThemeNumber - 1].subThemes.count
            currentQuestionNumber = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions.count
        } else if currentQuestionNumber == 1 && currentSubThemeNumber > 1 {
        
        currentSubThemeNumber -= 1
        currentQuestionNumber = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions.count
        } else {
            currentQuestionNumber -= 1
        }
        updateQuestion()
    }
    
    
}
