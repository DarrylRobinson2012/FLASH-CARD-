//
//  InsertTermController.swift
//  FLASH CARD
//
//  Created by Darryl Robinson  on 2/11/18.
//  Copyright © 2018 Darryl Robinson . All rights reserved.
//

import UIKit

class InsertTermController: UIViewController {
    @IBOutlet weak var View4: UIImageView!
    @IBOutlet weak var InsertTerm: UILabel!
    @IBOutlet weak var CheckAnswer: UIButton!
    @IBOutlet weak var displayTerm: UIButton!
    @IBOutlet weak var answerResults: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
