//
//  QuizViewController.swift
//  SofteamQuiz
//
//  Created by Guest User on 03/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    var score = 0
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
    
    @IBOutlet weak var optionsTableViewHeightConstraint: NSLayoutConstraint!
    
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
        
        self.optionsTableView.delegate = self
        self.optionsTableView.dataSource = self
        self.optionsTableView.isScrollEnabled = false
        
    }
    
    func restartTheme(num: Int){
        score = 0
        let currentTheme = allThemes[num - 1]
        for subTheme in currentTheme.subThemes {
            for question in subTheme.questions {
                question.isAnswered = false
                question.wrongAns = -1
            }
            
        }
        currentQuestionNumber = 1
        currentSubThemeNumber = 1
        currentThemeNumber = num
        
        updateQuestion()
        // updateUI()
        
    }
    
    func isValidated(themeNumber: Int) -> Bool {
        print("******************score: \(score)")
        var numebrOfQuestionInTheme = 0
        let currentTheme = allThemes[currentThemeNumber - 1]
        for subTheme in currentTheme.subThemes {
            for _ in subTheme.questions {
                numebrOfQuestionInTheme += 1
            }
            
        }
        
        let pourcentage = (score * 100)  / numebrOfQuestionInTheme
        print("pourcentage: \(pourcentage)")
        if pourcentage >= 60 {
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
        //        print("question number = ", currentQuestionNumber)
        //        print("sub theme number = ", currentSubThemeNumber)
        //        print("theme number = ", currentThemeNumber)
        //        print("========================================== \n")
        
        self.title = allThemes[currentThemeNumber - 1].title
        subThemeLabel.text = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].title
        questionRuleLabel.text = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1].rule
        let currentQuestion = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1]
        questionTextLabel.text = currentQuestion.questionText
        optionsTableView.reloadData()
        optionsTableView.layoutIfNeeded()
        optionsTableViewHeightConstraint.constant = CGFloat(currentQuestion.options.count * 50)
        updateUI()
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
                score = 0
            } else {
                restartTheme(num: currentThemeNumber)
            }
            
        } else {
            if isValidated(themeNumber: currentThemeNumber) {
                // print("fin fin")
                return
            } else {
                restartTheme(num: currentThemeNumber)
            }
            
        }
        updateQuestion()
    }
    
    @IBAction func previousQuestion(_ sender: Any) {
        
        if currentQuestionNumber == 1 && currentSubThemeNumber == 1 && currentThemeNumber == 1 {
            // print("debut")
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
        //print("question number: \(currentQuestionNumber - 1) isAnswered: \(currentQuestion.isAnswered) wrongAns: \(currentQuestion.wrongAns)")
        cell.contentView.backgroundColor = UIColor.gray
        if currentQuestion.isAnswered {
            tableView.allowsSelection = false
            if currentQuestion.wrongAns >= 0 {
                if currentQuestion.wrongAns == indexPath.row {
                    cell.contentView.backgroundColor = UIColor.red
                }
            } else if currentQuestion.correctAns - 1 == indexPath.row {
                cell.contentView.backgroundColor = UIColor.green
            }
        } else {
            tableView.allowsSelection = true
        }
        return cell
    }
}

extension QuizViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentQuestion = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1]
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        currentQuestion.isAnswered = true
        if indexPath.row == currentQuestion.correctAns - 1 {
            
            selectedCell.contentView.backgroundColor = UIColor.green
            score += 1
            
        } else {
            selectedCell.contentView.backgroundColor = UIColor.red
            currentQuestion.wrongAns = indexPath.row
            //score -= 1
        }
        tableView.allowsSelection = false
    }
}
