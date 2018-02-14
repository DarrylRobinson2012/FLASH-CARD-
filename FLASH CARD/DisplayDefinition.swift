//
//  view2.swift
//  FLASH CARD
//
//  Created by Darryl Robinson  on 2/6/18.
//  Copyright © 2018 Darryl Robinson . All rights reserved.
//

import UIKit

class view2: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var defintion: UITextView!
    @IBOutlet weak var view2ND: UIView!
    var quiz : studySession
    @IBOutlet weak var DisplayTerm: UIButton!
    
    // Grabs the plist and converts it to a format the code accepts it.
    required init?(coder aDecoder: NSCoder) {
        
        do {
            let array = try PlistConverter.array(fromFile: "SwiftVocab", ofType: "plist")
            let termsList = try inventoryUnarchiver.eventInventory(fromArray: array)
            quiz = studySession(card: termsList)
        } catch let error {
            
            fatalError("\(error)")
        }
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quiz.nextCard()
        refreshDisplay()
     
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func SwipeUp(_ sender: Any) {
        showTerm()
    }
    
    @IBAction func SwipeDown(_ sender: Any) {
        showEmptyTerm()
    }
    
 
    
    @IBAction func nextRound(_ sender: Any){
            quiz.nextCard()
            refreshDisplay()
        }
   
    
    func showTerm() {
    //shift to the term
        dismiss(animated: true, completion: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "vocabView") as! UIViewController
        self.present(vc, animated: true, completion: nil)
       
    }
    
    func showEmptyTerm(){
    //shift to the empty term page
        dismiss(animated: true, completion: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "insertTerm") as! UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func showStartQuiz() {
        view2ND.isHidden = false
        
    }
    
    func refreshDisplay() {
        defintion.text = quiz.test.cardTerm
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
