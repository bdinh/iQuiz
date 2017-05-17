//
//  QuizesTableViewController.swift
//  iQuiz
//
//  Created by Bao Dinh on 5/11/17.
//  Copyright © 2017 Bao Dinh. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class QuizesTableViewController: UITableViewController {
    
    var subjects: [QuizSubject] = []
    
    
    var images: [String] = []
    var selectedSubject = -1
    var URL = "https://tednewardsandbox.site44.com/questions.json"
    // https://tednewardsandbox.site44.com/questions.json
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh), for: UIControlEvents.valueChanged)
        attemptDownload()
    }
    
    func attemptDownload() {
        Alamofire.request(URL).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                self.deleteLocalData()
                self.downloadQuizes(response)
                self.tableView.reloadData()
                self.storeCoreData()
            case .failure(let error):
                print(error)
                self.loadLocalData()
                self.tableView.reloadData()
            }
        }
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        loadLocalData()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    func deleteLocalData() {
        subjects = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requestSubject = NSFetchRequest<NSFetchRequestResult>(entityName: "Subjects")
        let requestQuestion = NSFetchRequest<NSFetchRequestResult>(entityName: "Questions")
        requestSubject.returnsObjectsAsFaults = false
        requestQuestion.returnsObjectsAsFaults = false
        do {
            print("deleting all contents")
            let deleteSubject = NSBatchDeleteRequest(fetchRequest: requestSubject)
            let deleteQuestion = NSBatchDeleteRequest(fetchRequest: requestQuestion)
            try context.execute(deleteSubject)
            try context.execute(deleteQuestion)
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadLocalData() {
        subjects = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
                
        let requestSubject = NSFetchRequest<NSFetchRequestResult>(entityName: "Subjects")
        let requestQuestion = NSFetchRequest<NSFetchRequestResult>(entityName: "Questions")
        
        requestSubject.returnsObjectsAsFaults = false
        requestQuestion.returnsObjectsAsFaults = false
        do {
            let requestSubjects = try context.fetch(requestSubject)
            let requestQuestions = try context.fetch(requestQuestion)
            
            if requestSubjects.count > 0 && requestQuestions.count > 0 {
                for subs in requestSubjects as! [NSManagedObject] {
                    let addedSubject = QuizSubject()
                    var questionList: [QuizQuestion] = []
                    if let title = subs.value(forKey: "title") as? String {
                        addedSubject.title = title
                        for question in requestQuestions as! [NSManagedObject] {
                            let addedQuestion = QuizQuestion()
                            if let qTitle = question.value(forKey: "title") as? String {
                                if title == qTitle {
                                    if let qQuestion = question.value(forKey: "question") as? String {
                                        addedQuestion.question = qQuestion
                                    }
                                    if let qAnswer = question.value(forKey: "answer") as? String {
                                        addedQuestion.answer = qAnswer
                                    }
                                    if let qChoices = question.value(forKey: "choices") as? String {
                                        let choices = qChoices.components(separatedBy: "-")
                                        addedQuestion.choices = choices
                                    }
                                    questionList.append(addedQuestion)
                                }
                            }
                        }
                    }
                    if let icon = subs.value(forKey: "icon") as? String {
                        images.append(icon)
                    }
                    
                    if let description = subs.value(forKey: "desc") as? String {
                        addedSubject.description = description
                    }
                    addedSubject.questions = questionList
                    subjects.append(addedSubject)
                }
            }
        } catch let error as NSError  {
            print("Error in saving data. Error: \(error)")
        }
    }
    
    
    func storeCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        for i in 0...subjects.count - 1 {
            let storeSubject = NSEntityDescription.insertNewObject(forEntityName: "Subjects", into: context)
            
            storeSubject.setValue(subjects[i].title, forKey: "title")
            
//            storeSubject.setValue(subjects[i].questions, forKey: "question")
            storeSubject.setValue(subjects[i].title.lowercased() + ".png", forKey: "icon")
            storeSubject.setValue(subjects[i].description, forKey: "desc")
            let currentSubject = subjects[i]
            for j in 0...currentSubject.questions.count - 1 {
                let choicesString = subjects[i].questions[j].choices.joined(separator: "-")
                let storeQuestions = NSEntityDescription.insertNewObject(forEntityName: "Questions", into: context)
                storeQuestions.setValue(subjects[i].title, forKey: "title")
                storeQuestions.setValue(currentSubject.questions[j].question, forKey: "question")
                storeQuestions.setValue(choicesString, forKey: "choices")
                storeQuestions.setValue(currentSubject.questions[j].answer, forKey: "answer")
            }
        }
        do {
            try context.save()
        } catch let error as NSError  {
            print("Error in saving data. Error: \(error)")
        }
        
    }

    @IBAction func Settings(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Enter new url to update questions.", preferredStyle: .alert)
        alert.addTextField() { (textField) in
            textField.placeholder = "Enter URL Here"
        }
        
        let update = UIAlertAction(title: "Update", style: .default) { (_) in
            if let text = (alert.textFields![0] as UITextField).text {
                self.URL = text
                self.attemptDownload()
            }
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(update)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
        
    }

    
    func downloadQuizes(_ response: DataResponse<Any>) {
        if let JSON = response.result.value {
            if let dictionary = JSON as? [Dictionary<String, AnyObject>] {
                for i in 0...dictionary.count - 1 {
                    let addedSubject = QuizSubject()

                    if let description = dictionary[i]["desc"] as? String {
                        addedSubject.description = description
                    }
                    if let title = dictionary[i]["title"] as? String {
                        addedSubject.title = title
                        images.append(title)
                    }
                    if let questions = dictionary[i]["questions"] as? [Dictionary<String, AnyObject>] {
                        for j in 0...questions.count - 1 {
                            let addedQuestion = QuizQuestion()
                            if let answer = questions[j]["answer"] as? String {
                                addedQuestion.answer = answer
                            }
                            if let text = questions[j]["text"] as? String {
                                addedQuestion.question = text
                            }
                            if let choices = questions[j]["answers"] as? [String] {
                                addedQuestion.choices = choices
                            }
                            addedSubject.questions.append(addedQuestion)
                        }
                    }
                    self.subjects.append(addedSubject)
                }
            }
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.myImage.image = UIImage(named: images[indexPath.row] + ".png")
        cell.myLabel.text = subjects[indexPath.row].title
        cell.myDescription.text = subjects[indexPath.row].description
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizesToQuestions" {
            let cell = sender as! UITableViewCell
            let selectedRow = tableView.indexPath(for: cell)!.row
            let questionViewController = segue.destination as! QuestionViewController
            questionViewController.subjectIndex = selectedRow
            questionViewController.currentSubject = subjects[selectedRow].title
            
            
            questionViewController.subjects = subjects
        }
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
