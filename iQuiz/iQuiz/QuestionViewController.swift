//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Bao Dinh on 5/10/17.
//  Copyright © 2017 Bao Dinh. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var subjects: [QuizSubject] = []

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
            answerViewController.subjects = subjects
        }
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjects[subjectIndex].questions[currentQuestionIndex].choices[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects[subjectIndex].questions[currentAnswerIndex].choices.count
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentUserAnswer = subjects[subjectIndex].questions[currentAnswerIndex].choices[row]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        quizSubject.text = currentSubject
        currentQuestionDisplay.text = subjects[subjectIndex].questions[currentQuestionIndex].question
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
