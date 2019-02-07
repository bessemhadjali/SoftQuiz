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
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var optionsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeManager = ThemeManager.init()
        if let themeManager = themeManager {
            allThemes = themeManager.getAllThemes()
            updateQuestion()
            updateUI()
        } else {
            return
        }
        
        // self.optionsTableView.delegate = self
        self.optionsTableView.dataSource = self
        
    }
    
    func restartTheme(num: Int){
        currentQuestionNumber = 1
        currentSubThemeNumber = 1
        currentThemeNumber = num
        
        updateQuestion()
        updateUI()
        
    }
    
    func isValidated(themeNumber: Int) -> Bool {
        if allThemes[themeNumber - 1].score > 10 {
            return true
        }
        return false
    }
    
    func updateUI() {
        let subThemeCount = allThemes[currentThemeNumber - 1].subThemes.count
        let questionCount = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions.count
        if currentQuestionNumber == 1 && currentSubThemeNumber == 1 && currentThemeNumber == 1 {
            self.previousButton.isHidden = true
        } else {
            self.previousButton.isHidden = false
        }
        if currentSubThemeNumber == subThemeCount && currentQuestionNumber == questionCount {
            self.nextButton.setTitle("Valider le theme >", for: .normal)
        } else {
            self.nextButton.setTitle("Suivant >", for: .normal)
        }
    }
    func updateQuestion(){
        print("question number = ", currentQuestionNumber)
        print("sub theme number = ", currentSubThemeNumber)
        print("theme number = ", currentThemeNumber)
        print("========================================== \n")
        updateUI()
        self.title = allThemes[currentThemeNumber - 1].title
        subThemeLabel.text = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].title
        questionRuleLabel.text = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1].rule
        questionTextLabel.text = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1].questionText
        optionsTableView.reloadData()
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
            if isValidated(themeNumber: currentThemeNumber) {
                currentSubThemeNumber = 1
                currentQuestionNumber = 1
                currentThemeNumber += 1
            } else {
                restartTheme(num: currentThemeNumber)
            }
        } else {
            if isValidated(themeNumber: currentThemeNumber) {
                print("fin fin")
                return
            } else {
                restartTheme(num: currentThemeNumber)
            }
            
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

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentQuestion = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1]
        return currentQuestion.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCellIdentifier", for: indexPath)
        let currentQuestion = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1]
        let option = currentQuestion.options[indexPath.row]
        cell.textLabel?.text = option
        return cell
    }
    

    
    
}
