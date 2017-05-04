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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (subjects.count)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
//        cell.textLabel?.text = subjects[indexPath.row]
//        return (cell)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        cell.myImage.image = UIImage(named: images[indexPath.row] + ".png")
        cell.myLabel.text = subjects[indexPath.row]
        cell.myDescription.text = descriptions[indexPath.row]
        return cell
    }
    
    
    
    @IBAction func Settings(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

