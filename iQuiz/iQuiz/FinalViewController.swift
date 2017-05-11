//
//  FinalViewController.swift
//  iQuiz
//
//  Created by Bao Dinh on 5/11/17.
//  Copyright © 2017 Bao Dinh. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    let questions = [["What is 2 + 2?", "What is 1 * 9?", "What is 5 * 5?"],
                     ["Peter Parker works as a photographer for:", "S.H.I.E.L.D.'s highest ranking agent is:", "Captain America was frozen in which war?"],
                     ["Which of the following is a non metal that remains liquid at room temperature?","Decibel is the unit for?", "Atoms are composed of"]]
    
    var subjectIndex = -1
    var totalCorrect = 0
    var subject = ""


    
    @IBOutlet weak var subjectDisplay: UILabel!
    
    @IBOutlet weak var descriptionDisplay: UILabel!
    
    @IBOutlet weak var resultDisplay: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let totalPossible = questions[subjectIndex].count
        subjectDisplay.text = subject
        if totalCorrect == totalPossible {
            descriptionDisplay.text = "Way to get it all right!"
        } else if totalCorrect == totalPossible - 1 {
            descriptionDisplay.text = "Almost got it all right!"
        } else {
            descriptionDisplay.text = "Tough luck!"
        }
        resultDisplay.text = "Total Possible :\(totalPossible) Total Correct: \(totalCorrect)"

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
