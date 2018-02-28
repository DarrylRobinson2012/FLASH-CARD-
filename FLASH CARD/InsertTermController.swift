//
//  InsertTermController.swift
//  FLASH CARD
//
//  Created by Darryl Robinson  on 2/11/18.
//  Copyright © 2018 Darryl Robinson . All rights reserved.
//

import UIKit

class InsertTermController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var View4: UIImageView!
    @IBOutlet weak var InsertTerm: UITextView!
    @IBOutlet weak var CheckAnswer: UIButton!
    @IBOutlet weak var displayTerm: UIButton!
    @IBOutlet weak var answerResults: UIImageView!
    var term:  String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      answerResults.isHidden = true
  
        
        // Do any additional setup after loading the view.
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    @IBAction func term(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Definition") as! UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func check(_ sender: Any)  {
        if InsertTerm.text == term {
            answerResults.isHidden = false
            performSegue(withIdentifier: "showTheTerm ", sender: self)
            return answerResults.image = #imageLiteral(resourceName: "correct.png")
        } else {
            answerResults.isHidden = false
            performSegue(withIdentifier: "showTheTerm ", sender: self)
        
            return answerResults.image = #imageLiteral(resourceName: "incorrect.ico")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   
    
    
    func loadNextViewWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.performSegue(withIdentifier: "showTheTerm ", sender: self)
            self.closeView()
            
        }
    }
    
    
    
    func closeView() {
        dismiss(animated: true, completion: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "vocabView") as! UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TermFinalController {
            destination.term = term
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
}
