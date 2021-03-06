//
//  termController.swift
//  FLASH CARD
//
//  Created by Darryl Robinson  on 2/11/18.
//  Copyright © 2018 Darryl Robinson . All rights reserved.
//

import UIKit

class termController: UIViewController {
    @IBOutlet weak var Term: UILabel!
    @IBOutlet weak var Next: UIButton!
    @IBOutlet weak var previousCard: UIButton!
    @IBOutlet weak var View4: UIImageView!
    var term: String?
    var def: String?
    var quiz : studySession
    required init?(coder aDecoder: NSCoder) {
        
        do {
            let array = try PlistConverter.array(fromFile: "Vocab", ofType: "plist")
            let termsList = try inventoryUnarchiver.eventInventory(fromArray: array)
            quiz = studySession(card: termsList)
        } catch let error {
            
            fatalError("\(error)")
        }
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshDisplay()
        // Do any additional setup after loading the view.
        if let termTodisplay = term {
            Term.text = termTodisplay
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backTodefiniton(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Definition") as! UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func newDefinition(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Definition") as! UIViewController
        self.present(vc, animated: true, completion: nil)
        performSegue(withIdentifier: "newDefinition", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? view2 {
           destination.definit2 = "huh"
            destination.definit = nil
        }
    }
    func refreshDisplay() {
       //performSegue(withIdentifier: "newDefinition", sender: self)
        Term.text = quiz.test.cardKeyword
        def = quiz.test.cardTerm
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
