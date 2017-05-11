//
//  ViewController.swift
//  iQuiz
//
//  Created by Bao Dinh on 5/2/17.
//  Copyright © 2017 Bao Dinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
    let images = ["Math", "Marvel", "Science"]
    let descriptions = ["This is the Math section", "This is the Marvel section", "This is the Science section"]
    var selectedSubject = -1
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    @IBOutlet weak var TableView: UITableView!
    
   public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.myImage.image = UIImage(named: images[indexPath.row] + ".png")
        cell.myLabel.text = subjects[indexPath.row]
        cell.myDescription.text = descriptions[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizesToQuestion" {
            let cell = sender as! UITableViewCell
            let selectedRow = TableView.indexPath(for: cell)?.row
            let newViewController = segue.destination as! QuestionViewController
//            let selectedRow = tableView.indexPath(for: cell)!.row
            newViewController.subjectIndex = selectedRow!

            

        }
        
    }
    
    
    
    
    @IBAction func Settings(_ sender:
        UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
//    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var selectedSubject = tableView.indexPath
//        print(tableView.indexPath())
//        performSegue(withIdentifier: "quizesToQuestion", sender: self)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

