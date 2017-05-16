//
//  QuizSubject.swift
//  iQuiz
//
//  Created by Bao Dinh on 5/15/17.
//  Copyright © 2017 Bao Dinh. All rights reserved.
//

import Foundation

class QuizSubject {
    
    var title: String
    var description: String
    var questions: [QuizQuestion]
    
    init(_ title: String, _ description: String, _ questions: [QuizQuestion]) {
        self.title = title
        self.description = description
        self.questions = questions
    }
    
}
