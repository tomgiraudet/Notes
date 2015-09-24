//
//  adding.swift
//  Note
//
//  Created by Tom Giraudet on 09/02/2015.
//  Copyright (c) 2015 Tom Giraudet. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Adding: UIViewController, UITextViewDelegate {
    
    // Declaration of boths editing fields
    @IBOutlet weak var myTitleView: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    var parent:ViewController!
    
    // Indicate what's appears when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextView.delegate = self
        myTextView.layer.cornerRadius = 5.0;
    }
    
    
    // Dispose of any resources that can be recreated
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Function called when '+' is pressed
    @IBAction func addNotesButtonPressed(sender: AnyObject) {
        parent.saveNewItem(myTitleView.text!,contentsToAdd: myTextView.text!)
        print("Note added")
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vcHome : ViewController = mainStoryboard.instantiateViewControllerWithIdentifier("homeId") as! ViewController
        vcHome.parent = self
        self.presentViewController(vcHome, animated: true, completion: nil)
    }
    
    // Function call when "back" is pressed
    @IBAction func backButtonPressed(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vcHome : ViewController = mainStoryboard.instantiateViewControllerWithIdentifier("homeId") as! ViewController
        vcHome.parent = self
        self.presentViewController(vcHome, animated: true, completion: nil)
    }
}
