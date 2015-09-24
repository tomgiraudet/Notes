//
//  MyNotesViewController.swift
//  Notes
//
//  Created by Tom Giraudet on 27/01/2015.
//  Copyright (c) 2015 Tom Giraudet. All rights reserved.
//

import UIKit
import Foundation

class MyNotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var nbNotes:Int!
    var tabNotes:NSMutableArray!
    
    @IBOutlet weak var listeNotesTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listeNotesTableView.dataSource = self
        listeNotesTableView.delegate = self
        
        // Cas 1 : Pas de note lors de l'arrivée sur la view
        if(NSUserDefaults.standardUserDefaults().objectForKey("nbNotes") == nil){
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "nbNotes")
            nbNotes = 0
            println("Message: premier lancement car <nbNotes; nil>")
        }else{
            
        // Cas 2 : Affichage des notes présentes
            self.nbNotes = NSUserDefaults.standardUserDefaults().objectForKey("nbNotes") as Int
            println("nbNotes = \(self.nbNotes)")
            
            tabNotes = NSMutableArray(capacity: nbNotes)
            println("Tableau créé")
            
            for(var i = 0;i<self.nbNotes;i++){
                println("Note \(i)")
                //tabNotes[i] = NSUserDefaults.standardUserDefaults().valueForKey("\(i)") as String
            }
            println("chargement des notes réussi")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Hauteur d'une cellule
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        var height = CGFloat(50)
        return height
    }
    
    
    // Méthodes à réécrire car implémentation de UITableViewDataSource
                func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
                    println("Début méthode tableView")
                    var cell = UITableViewCell()
                    println("Création cellule \(indexPath.row) réussie")
                    //Label contenant le titre
                    var titleLabel = UILabel(frame: CGRectMake(5,5,400,40))
                    println("Création du label correspondant")
                    //titleLabel.text = tabNotes[indexPath.row] as? String
                    titleLabel.text = "Note \(indexPath.row+1)"
                    println("Ajout du text de la note dans le label de la cellule")
                    cell.addSubview(titleLabel)
                    println("Chargement de la cellule \(indexPath.row) réussi")
                    return cell
                }
                
                func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
                    // nombre de cellules
                    return self.nbNotes
                }

    
    

    
    
    
}