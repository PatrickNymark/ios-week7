//
//  ViewController.swift
//  CustomTableApplication
//
//  Created by Patrick Nymark on 17/05/2020.
//  Copyright © 2020 Patrick Nymark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var posts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        // setup only on initial load
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addClicked))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateTasks()
    }
    
    @objc func addClicked() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "add") as! AddViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateTasks() {
        posts.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            if let post = UserDefaults().value(forKey: "post_\(x + 1)") as? String {
                posts.append(post)
            }
        }
        
        tableView.reloadData()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
                
        cell.postTitle?.text = posts[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            guard let currentCount = UserDefaults().value(forKey: "count") as? Int else {
                return
            }
            
            let newCount = currentCount - 1
            UserDefaults().setValue(newCount, forKey: "count")
            UserDefaults().setValue(nil, forKey: "task_\(indexPath.row + 1)")
            updateTasks()
        }
    }
}


