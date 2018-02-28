//
//  TermFinalController.swift
//  FLASH CARD
//
//  Created by Darryl Robinson  on 2/21/18.
//  Copyright © 2018 Darryl Robinson . All rights reserved.
//

import UIKit

class TermFinalController: UIViewController {
    
    @IBOutlet weak var Term: UILabel!
    @IBOutlet weak var NextTerm: UIButton!
    var term: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let termTodisplay = term {
            Term.text = termTodisplay
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
