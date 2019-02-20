//
//  QuizViewController.swift
//  SofteamQuiz
//
//  Created by Guest User on 03/02/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit
import SCLAlertView

class QuizViewController: UIViewController {
    var score = 0
    var themeManager: ThemeManager?
    var allThemes = [Theme]()
    var currentTheme:Theme?
    var currentSubTheme:SubTheme?
    var currentQuestion: Question?
    var currentQuestionNumber = 1
    var currentThemeNumber = 1
    var currentSubThemeNumber = 1
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var subThemeLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var optionsTableView: SelfSizedTableView!
    
    @IBOutlet weak var optionsTableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        themeManager = ThemeManager()
        if let themeManager = themeManager {
            allThemes = themeManager.getAllThemes()
            updateUI()
        } else {
            return
        }
        
        self.optionsTableView.delegate = self
        self.optionsTableView.dataSource = self
        self.optionsTableView.isScrollEnabled = false
        
        
    }
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.optionsTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.optionsTableView.removeObserver(self, forKeyPath: "contentSize")
        super.viewWillDisappear(true)
    }
    
    //Observe the table view size changes
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            
            if let newvalue = change?[.newKey]{
                let newsize  = newvalue as! CGSize
                optionsTableViewHeightConstraint.constant = newsize.height
                
            }
        }
    }
    
    //This method is called when the theme is not validated
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
        
        updateUI()
        
    }
    
    // Check if the theme is validated
    func isValidated(themeNumber: Int) -> Bool {
        
        // Get the number of question in the current theme
        var numebrOfQuestionsInTheme = 0
        for subTheme in currentTheme!.subThemes {
            for _ in subTheme.questions {
                numebrOfQuestionsInTheme += 1
            }
            
        }
        // Calculate the pourcentage of correct answers % all question
        let pourcentage = (score * 100)  / numebrOfQuestionsInTheme
        
        // check if the percentage obtained respects the percentage needed to validate the current theme
        switch currentThemeNumber {
        case 1:
            return pourcentage >= 90 ? true : false
        case 2:
            return pourcentage >= 80 ? true : false
        case 3:
            return pourcentage >= 75 ? true : false
        case 4:
            return pourcentage >= 100 ? true : false
        default:
            return false
        }
        
    }
    
    // Setup the UI of current question
    func updateUI() {
        
        updateQuestion()
        
        let subThemeCount = currentTheme!.subThemes.count
        let questionCount = currentSubTheme!.questions.count
        
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
        
        currentTheme = allThemes[currentThemeNumber - 1]
        currentSubTheme = currentTheme!.subThemes[currentSubThemeNumber - 1]
        currentQuestion = currentSubTheme!.questions[currentQuestionNumber - 1]
        
        themeLabel.text = currentTheme!.title
        subThemeLabel.text = currentSubTheme!.title
        questionTextLabel.text = currentQuestion!.questionText
        optionsTableView.reloadData()
        
    }
    
    //Show rule of current question
    @IBAction func infoQuestionAction(_ sender: Any) {
        let rule = currentQuestion!.rule
        let appearance = SCLAlertView.SCLAppearance(dynamicAnimatorActive: true)
        SCLAlertView(appearance: appearance).showInfo("Info", subTitle: rule, closeButtonTitle:"OK")
    }
    
    // Go to the next question
    @IBAction func nextQuestionAction(_ sender: Any) {
        
        let themesCount = allThemes.count
        let subThemeCount = currentTheme!.subThemes.count
        let questionCount = currentSubTheme!.questions.count
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
            } else {
                restartTheme(num: currentThemeNumber)
            }
            
        }
        updateUI()
    }
    
    // Return to the previous question
    @IBAction func previousQuestion(_ sender: Any) {
        
        if currentQuestionNumber == 1 && currentSubThemeNumber == 1 && currentThemeNumber == 1 {
            // print("debut")
            
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
        updateUI()
    }
    
    
}

extension QuizViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion!.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCellIdentifier", for: indexPath) as! ResponseOptionCell
        cell.selectionStyle = .none
        let option = currentQuestion!.options[indexPath.row]
        cell.optionText.text = option
        cell.contentView.backgroundColor = UIColor.white
        cell.optionContainer.backgroundColor = UIColor.white
        
        if currentQuestion!.isAnswered {
            tableView.allowsSelection = false
            if currentQuestion!.wrongAns >= 0 {
                if currentQuestion!.wrongAns == indexPath.row {
                    cell.optionContainer.backgroundColor = SofteamColor.Failed.UIColorFromRGB()
                }
            } else if currentQuestion!.correctAns - 1 == indexPath.row {
                cell.optionContainer.backgroundColor = SofteamColor.Success.UIColorFromRGB()
            }
        } else {
            tableView.allowsSelection = true
        }
        return cell
    }
}

extension QuizViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! ResponseOptionCell
        currentQuestion!.isAnswered = true
        
        if indexPath.row == currentQuestion!.correctAns - 1 {
            
            selectedCell.optionContainer.backgroundColor = SofteamColor.Success.UIColorFromRGB()
            score += 1
            
            SCLAlertView().showSuccess("Réponse exacte", subTitle: currentQuestion!.comment, closeButtonTitle: "OK")
            
        } else {
            
            selectedCell.optionContainer.backgroundColor = SofteamColor.Failed.UIColorFromRGB()
            
            currentQuestion!.wrongAns = indexPath.row
            
            SCLAlertView().showError("Réponse fausse", subTitle: currentQuestion!.comment, closeButtonTitle: "OK")
            //score -= 1
        }
        tableView.allowsSelection = false
    }
}
