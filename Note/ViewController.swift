//
//  ViewController.swift
//  Note
//
//  Created by Tom Giraudet on 09/02/2015.
//  Copyright (c) 2015 Tom Giraudet. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    var NotesArray = [Note]()
    @IBOutlet weak var tableNote: UITableView!
    var parent: Adding!
    var parentbis: Editing!
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
            }
        }()

    // Indicate what's appears when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableNote.dataSource = self
        tableNote.delegate = self
        
        fetchNotes()
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Indicates the number of notes
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotesArray.count
    }
    
    
    // Indicates the contents of cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "TaskCell")
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "TaskCell")
        
        cell.textLabel?.text = "\(indexPath.row+1). \(NotesArray[indexPath.row].title)"
        cell.detailTextLabel?.text = NotesArray[indexPath.row].contents
        cell.backgroundColor = UIColor(red: 250, green: 255, blue: 138, alpha: 0)
        
        
        return cell
    }
    
    
    // Refresching the table hosting the notes
    func fetchNotes() {
        let fetchRequest = NSFetchRequest(entityName: "Note")
        if let fetchResults = (try? managedObjectContext!.executeFetchRequest(fetchRequest)) as? [Note] {
            NotesArray = fetchResults
        }
    }
    
    
    // True if cell can be editing (Dans notre cas, elles pourront toutes êtes supprimées)
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    // Implements Slide/Delete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            // Find the Note object the user is trying to delete
            let NoteToDelete = NotesArray[indexPath.row]
            
            // Delete it from the managedObjectContext
            managedObjectContext?.deleteObject(NoteToDelete)
            
            // Refresh the table view to indicate that it's deleted
            self.fetchNotes()
            
            // Tell the table view to animate out that row
            tableNote.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    
    // Function used to create and save a new note composed by the title and the contents of both fields
    func saveNewItem(titleToAdd: String, contentsToAdd: String) {
        // Creation of the new note
        let noteToAdd = Note.createInManagedObjectContext(self.managedObjectContext!, title: titleToAdd, contents: contentsToAdd)
        
        
        // Adding the note created to ArrayNotes
        if let noteToAddIndex = NotesArray.indexOf(noteToAdd) {
            
            let noteToAddIndexPath = NSIndexPath(forRow: noteToAddIndex, inSection: 0)
            tableNote.insertRowsAtIndexPaths([ noteToAddIndexPath ], withRowAnimation: .Automatic)
        }
        
        save()
    }
    
    // Function used to update a note
    func updateItem(titleToUpdate: String, contentsToUpdate: String, indexPathRowNoteToUpdate: Int) {
        print(NotesArray[indexPathRowNoteToUpdate].title)
        NotesArray[indexPathRowNoteToUpdate].title = titleToUpdate
        NotesArray[indexPathRowNoteToUpdate].contents = contentsToUpdate
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedNote = NotesArray[indexPath.row]
        let titleSelected = selectedNote.title
        let contentsSelected = selectedNote.contents
        let indexPathRowSelected = indexPath.row
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vcEditing : Editing = mainStoryboard.instantiateViewControllerWithIdentifier("EditViewId") as! Editing
        vcEditing.parent = self
        
        vcEditing.titleToBeModify = titleSelected
        vcEditing.contentsToBeModify = contentsSelected
        vcEditing.indexPathRowToBeModify = indexPathRowSelected
        
        self.presentViewController(vcEditing, animated: true, completion: nil)
        
    }
    
    @IBAction func writeNote(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vcAdding : Adding = mainStoryboard.instantiateViewControllerWithIdentifier("addViewId")as! Adding
        vcAdding.parent = self
        self.presentViewController(vcAdding, animated: true, completion: nil)
    }
    
    
    func save() {
        let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        //let managedContext = appDelegate.managedObjectContext!
        //var error: NSError?
        do {
            try managedContext.save()
        }
        catch{
                print("Could not save") // \(error), \(error?.userInfo)")
            }
        }
    }

 