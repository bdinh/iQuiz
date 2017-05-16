//
//  QuizQuestion.swift
//  iQuiz
//
//  Created by Bao Dinh on 5/15/17.
//  Copyright © 2017 Bao Dinh. All rights reserved.
//

import Foundation

class QuizQuestion {
    var question: String
    var choices: [String]
    var answer: String
    
    init(_ question: String, _ choices: [String], _ answer: String) {
        self.question = question
        self.choices = choices
        self.answer = answer
    }
}
