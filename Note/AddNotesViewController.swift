//
//  AddNotesViewController.swift
//  Notes
//
//  Created by Tom Giraudet on 29/01/2015.
//  Copyright (c) 2015 Tom Giraudet. All rights reserved.
//

import UIKit
import Foundation

class AddNotesViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var myTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addNote(sender: AnyObject) {
        var nbNotes: Int? = NSUserDefaults.standardUserDefaults().objectForKey("nbNotes") as? Int
        var key:String = "\(nbNotes)"
        print("key = \(key)")
        print("contenu = \(myTextView.text)")
        NSUserDefaults.standardUserDefaults().setValue(myTextView.text, forKey: key)
        nbNotes = nbNotes! + 1
        NSUserDefaults.standardUserDefaults().setObject(nbNotes, forKey: "nbNotes")
        nbNotes = NSUserDefaults.standardUserDefaults().objectForKey("nbNotes") as? Int
        print("nbNotes = \(nbNotes)")
        var notes = NSUserDefaults.standardUserDefaults().valueForKey(key) as? String
        print("notes = \(notes)")
        print("note ajoutée")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textViewDidBeginEditing(textView: UITextView){
        myTextView.text = ""
    }
}