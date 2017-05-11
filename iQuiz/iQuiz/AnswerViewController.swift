//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Bao Dinh on 5/11/17.
//  Copyright © 2017 Bao Dinh. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    let questions = [["What is 2 + 2?", "What is 1 * 9?", "What is 5 * 5?"],
                     ["Peter Parker works as a photographer for:", "S.H.I.E.L.D.'s highest ranking agent is:", "Captain America was frozen in which war?"],
                     ["Which of the following is a non metal that remains liquid at room temperature?","Decibel is the unit for?", "Atoms are composed of"]]
    
    let correctAnswers = [["4", "9", "25"],
                          ["The Daily Bugle", "Nick Fury", "World War II"],
                          ["Bromine", "intensity of sound", "electrons and nuclei"]]
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
        if currentQuestionIndex + 1 == questions[subjectIndex].count {
            performSegue(withIdentifier: "FinalSummary", sender: self)
        } else {
            performSegue(withIdentifier: "remainingQuestion", sender: self)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentSubject.text = subject
        currentQuestionDisplay.text = "Question: " + questions[subjectIndex][currentQuestionIndex]
        correctAnswerDisplay.text = "Correct Answer: " + correctAnswers[subjectIndex][currentQuestionIndex]
        userAnswerDisplay.text = "User Answer: " + userAnswer
        if userAnswer == correctAnswers[subjectIndex][currentQuestionIndex] {
            totalCorrect += 1
        }

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
        } else if segue.identifier == "FinalSummary" {
            let finalViewController = segue.destination as! FinalViewController
            finalViewController.subjectIndex = subjectIndex
            finalViewController.subject = subject
            finalViewController.totalCorrect = totalCorrect
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
