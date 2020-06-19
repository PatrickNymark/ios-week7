//
//  AddViewController.swift
//  CustomTableApplication
//
//  Created by Patrick Nymark on 17/05/2020.
//  Copyright © 2020 Patrick Nymark. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var titleInput: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleInput.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        save()
        return true
    }
    
    @objc func save() {
        guard let text = titleInput.text, !text.isEmpty else {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        print(newCount)
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "post_\(newCount)")
        
        update?()
        
        navigationController?.popToRootViewController(animated: true)
    }

}
