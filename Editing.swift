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


class Editing: UIViewController, UITextViewDelegate {
    
    // Declaration of boths editing fields
    @IBOutlet weak var myTitleView: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    var titleToBeModify: String = ""
    var contentsToBeModify: String = ""
    var indexPathRowToBeModify: Int = 0

    var parent:ViewController!
    
    // Indicate what's appears when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextView.delegate = self
        myTextView.layer.cornerRadius = 5.0;
        
        myTitleView.text = titleToBeModify
        myTextView.text = contentsToBeModify
        print(indexPathRowToBeModify)
        
    }
    
    
    // Dispose of any resources that can be recreated
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    @IBAction func saveNotesButtonPressed(sender: AnyObject) {
        
        //parent.saveNewItem(myTitleView.text,contentsToAdd: myTextView.text)
        parent.updateItem(myTitleView.text!, contentsToUpdate: myTextView.text, indexPathRowNoteToUpdate: indexPathRowToBeModify)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vcHome : ViewController = mainStoryboard.instantiateViewControllerWithIdentifier("homeId") as! ViewController
        vcHome.parentbis = self
        
        self.presentViewController(vcHome, animated: true, completion: nil)
        print("save")
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vcHome : ViewController = mainStoryboard.instantiateViewControllerWithIdentifier("homeId") as! ViewController
        vcHome.parentbis = self
        
        self.presentViewController(vcHome, animated: true, completion: nil)
    }
    
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        let textToShare = myTextView.text
        
        if let _ = NSURL(string: "http://www.codingexplorer.com/")
        {
            let objectsToShare = [textToShare]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    

}
