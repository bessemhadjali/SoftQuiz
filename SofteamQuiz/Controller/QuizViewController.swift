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
    var currentQuestionNumber = 1
    var currentThemeNumber = 1
    var currentSubThemeNumber = 1
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var themeContainer: UIView!
    
    @IBOutlet weak var subThemeLabel: UILabel!
    @IBOutlet weak var subThemeContainer: UIView!
    
    
    @IBOutlet weak var questionTextLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var optionsTableView: SelfSizedTableView!
    
    @IBOutlet weak var optionsTableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        themeManager = ThemeManager()
        if let themeManager = themeManager {
            allThemes = themeManager.getAllThemes()
            updateQuestion()
            updateUI()
        } else {
            return
        }
        
        self.optionsTableView.delegate = self
        self.optionsTableView.dataSource = self
        //self.optionsTableView.estimatedRowHeight = 60
        //self.optionsTableView.maxHeight = 50
        self.optionsTableView.isScrollEnabled = false
       // optionsTableView.backgroundColor = UIColor.white
        
        setupView()
        
    }
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.optionsTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.optionsTableView.removeObserver(self, forKeyPath: "contentSize")
        super.viewWillDisappear(true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        if(keyPath == "contentSize"){
            
            if let newvalue = change?[.newKey]{
                let newsize  = newvalue as! CGSize
                optionsTableViewHeightConstraint.constant = newsize.height
                //self.heightofinstructioncontainerview.constant = newsize.height
            }
        }
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        optionsTableViewHeightConstraint.constant = optionsTableView.contentSize.height
//    }
    @IBAction func infoQuestionAction(_ sender: Any) {
        let rule = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1].rule
        let appearance = SCLAlertView.SCLAppearance(dynamicAnimatorActive: true)
        SCLAlertView(appearance: appearance).showInfo("Info", subTitle: rule, closeButtonTitle:"OK")
       
//        SCLAlertView().showTitle("Info", subTitle: rule, style: .info, closeButtonTitle: "Ok", timeout: 2, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF)
//
//        SCLAlertView().showTitle(
//            "Congratulations", // Title of view
//            subTitle: "Operation successfully completed.", // String of view
//            duration: 2.0, // Duration to show before closing automatically, default: 0.0
//            completeText: "Done", // Optional button value, default: ""
//            style: .success, // Styles - see below.
//            colorStyle: 0xA429FF,
//            colorTextButton: 0xFFFFFF
//        )
    }
    
    func setupView () {
        self.themeContainer.layer.cornerRadius = 7.0
        self.themeContainer.layer.borderWidth = 0.0
        self.themeContainer.layer.borderColor = UIColor.clear.cgColor
        self.themeContainer.layer.masksToBounds = true
        
        self.subThemeContainer.layer.cornerRadius = 7.0
        self.subThemeContainer.layer.borderWidth = 0.0
        self.subThemeContainer.layer.borderColor = UIColor.clear.cgColor
        self.subThemeContainer.layer.masksToBounds = true
        
        
        self.nextButton.layer.cornerRadius = 7.0
        self.nextButton.layer.borderWidth = 0.0
        self.nextButton.layer.borderColor = UIColor.clear.cgColor
        self.nextButton.layer.masksToBounds = true
        
        self.previousButton.layer.cornerRadius = 7.0
        self.previousButton.layer.borderWidth = 0.0
        self.previousButton.layer.borderColor = UIColor.clear.cgColor
        self.previousButton.layer.masksToBounds = true
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
        // print("******************score: \(score)")
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
        
        themeLabel.text = allThemes[currentThemeNumber - 1].title
        subThemeLabel.text = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].title
        let currentQuestion = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1]
        questionTextLabel.text = currentQuestion.questionText
        optionsTableView.reloadData()
        //optionsTableView.layoutIfNeeded()
        //optionsTableViewHeightConstraint.constant = CGFloat(currentQuestion.options.count * 50)
        //optionsTableViewHeightConstraint.constant = optionsTableView.contentSize.height
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCellIdentifier", for: indexPath) as! ResponseOptionCell
        cell.selectionStyle = .none
        let currentQuestion = allThemes[currentThemeNumber - 1].subThemes[currentSubThemeNumber - 1].questions[currentQuestionNumber - 1]
        let option = currentQuestion.options[indexPath.row]
        cell.optionText.text = option
        //print("question number: \(currentQuestionNumber - 1) isAnswered: \(currentQuestion.isAnswered) wrongAns: \(currentQuestion.wrongAns)")
        cell.contentView.backgroundColor = UIColor.white
        cell.optionContainer.backgroundColor = UIColor.white
        
        if currentQuestion.isAnswered {
            tableView.allowsSelection = false
            if currentQuestion.wrongAns >= 0 {
                if currentQuestion.wrongAns == indexPath.row {
                    cell.optionContainer.backgroundColor = UIColor.red
                }
            } else if currentQuestion.correctAns - 1 == indexPath.row {
                cell.optionContainer.backgroundColor = UIColor.green
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
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! ResponseOptionCell
        currentQuestion.isAnswered = true
        if indexPath.row == currentQuestion.correctAns - 1 {
            
             selectedCell.optionContainer.backgroundColor = UIColor.green
            score += 1
            SCLAlertView().showSuccess("FÉLICITATIONS", subTitle: "BlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBla", closeButtonTitle: "OK")
            
        } else {
             selectedCell.optionContainer.backgroundColor = UIColor.red
            currentQuestion.wrongAns = indexPath.row
            SCLAlertView().showError("CORRECTION", subTitle: "BlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBlaBla", closeButtonTitle: "OK")
            //score -= 1
        }
        tableView.allowsSelection = false
    }
}
