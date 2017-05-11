//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Bao Dinh on 5/10/17.
//  Copyright © 2017 Bao Dinh. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let questions = [["What is 2 + 2?", "What is 1 * 9?", "What is 5 * 5?"],
                     ["Peter Parker works as a photographer for:", "S.H.I.E.L.D.'s highest ranking agent is:", "Captain America was frozen in which war?"],
                     ["Which of the following is a non metal that remains liquid at room temperature?","Decibel is the unit for?", "Atoms are composed of"]]
    
    let  answers = [[["5", "4", "2", "1"],["3", "5", "8", "9"],["3", "5", "8", "25"]],
                    [["The Daily Planet", "The Daily Bugle", "The New York Times", "The Rolling Stone"],["Steven Rogers", "Peter Parker", "Nick Fury", "Natalia Romanova"],["World War I", "World War II", "Cold War", "American Civil War"]],
                    [["Phosphorous", "Bromine", "Chlorine", "Helium"], ["speed of light", "radio wave frequency", "intensity of sound", "intensity of heat"], ["electrons only", "electrons and protons", "protons only", "electrons and nuclei"]]]
    var currentQuestionIndex = 0
    var currentAnswerIndex = 0
    var currentUserAnswer = ""
    var subjectIndex = -1
    var currentSubject = ""
    var totalCorrect = 0
    
    @IBOutlet weak var quizSubject: UILabel!
    
    
    
    @IBOutlet weak var currentQuestionDisplay: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questionToAnswer" {
            let answerViewController = segue.destination as! AnswerViewController
            answerViewController.userAnswer = currentUserAnswer
            answerViewController.currentQuestionIndex = currentQuestionIndex
            answerViewController.subjectIndex = subjectIndex
            answerViewController.subject = currentSubject
            answerViewController.totalCorrect = totalCorrect
        }
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return answers[subjectIndex][currentAnswerIndex][row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answers[subjectIndex][currentAnswerIndex].count
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentUserAnswer = answers[subjectIndex][currentAnswerIndex][row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        quizSubject.text = currentSubject
        currentQuestionDisplay.text = questions[subjectIndex][currentQuestionIndex]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
