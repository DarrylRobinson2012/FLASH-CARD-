//
//  ViewController.swift
//  FLASH CARD
//
//  Created by Darryl Robinson  on 1/31/18.
//  Copyright © 2018 Darryl Robinson . All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
        //two labels and a 5 sec delay
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var positioningLabel: UILabel!
    var quiz: studySession

    var term: String?
    var definition: String?
    
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
        loadNextViewWithDelay(seconds: 5)
            
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }

    func loadNextViewWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
           // self.sendTheStrings()
            self.closeView()
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? view2 {
            destination.definit = definition
            destination.keyword = term
        }
    }
    func sendTheStrings(){
        performSegue(withIdentifier: "launchMode", sender: self)
        
    }
    
    func fillTheStrings() {
        quiz.nextCard()
        term = quiz.test.cardKeyword
        definition = quiz.test.cardTerm
        
    }
    
    func closeView() {
        dismiss(animated: true, completion: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Definition") as! UIViewController
        self.present(vc, animated: true, completion: nil)
        definition = nil
        
    }
}


