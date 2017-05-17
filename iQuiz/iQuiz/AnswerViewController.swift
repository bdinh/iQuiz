//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Bao Dinh on 5/11/17.
//  Copyright © 2017 Bao Dinh. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var subjects: [QuizSubject] = []
    var userAnswer = ""
    var currentQuestionIndex = 0
    var subjectIndex = -1
    var totalCorrect = 0
    var subject = ""
    
    @IBOutlet weak var currentSubject: UILabel!
    @IBOutlet weak var currentQuestionDisplay: UILabel!
    @IBOutlet weak var correctAnswerDisplay: UILabel!
    @IBOutlet weak var userAnswerDisplay: UILabel!
    
    @IBAction func nextQuestion(_ sender: Any) {
        if currentQuestionIndex + 1 == subjects[subjectIndex].questions.count {
            performSegue(withIdentifier: "FinalSummary", sender: self)
        } else {
            performSegue(withIdentifier: "remainingQuestion", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentSubject.text = subject
        currentQuestionDisplay.text = "Question: " + subjects[subjectIndex].questions[currentQuestionIndex].question
        var correctIndex: Int = Int(subjects[subjectIndex].questions[currentQuestionIndex].answer)! - 1
        var correctAnswer: String = subjects[subjectIndex].questions[currentQuestionIndex].choices[correctIndex]
        correctAnswerDisplay.text = "Correct Answer: " + correctAnswer
        if userAnswer == "" {
            userAnswer = subjects[subjectIndex].questions[currentQuestionIndex].choices[0]
        }
        if userAnswer == correctAnswer {
            totalCorrect += 1
        }
        userAnswerDisplay.text = "User Answer: " + userAnswer
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "remainingQuestion" {
            let questionViewController = segue.destination as! QuestionViewController
            questionViewController.currentQuestionIndex = currentQuestionIndex + 1
            questionViewController.subjectIndex = subjectIndex
            questionViewController.currentSubject = subject
            questionViewController.currentAnswerIndex = currentQuestionIndex + 1
            questionViewController.totalCorrect = totalCorrect
            questionViewController.subjects = subjects
        } else if segue.identifier == "FinalSummary" {
            let finalViewController = segue.destination as! FinalViewController
            finalViewController.subjectIndex = subjectIndex
            finalViewController.subject = subject
            finalViewController.totalCorrect = totalCorrect
            finalViewController.subjects = subjects
        }
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
