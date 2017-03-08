//
//  EyeCoverInstructionViewController.swift
//  Franklin
//
//  Created by Takashi Wickes on 2/28/17.
//  Copyright © 2017 Franklin. All rights reserved.
//

import UIKit

class EyeCoverInstructionViewController: UIViewController {

    var rightDone: Bool?
    var leftDone: Bool?
    var prescription: [String] = [String]()
    var inputType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "testNextEye", sender: self)

        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nextController: ExamViewController = segue.destination as! ExamViewController
        nextController.prescription = self.prescription
        nextController.inputType = self.inputType
        nextController.rightDone = self.rightDone
        nextController.leftDone = self.leftDone
        
        // Set the delegate on the singleton SpeechManager
        SpeechManager.sharedInstance.inputDelegate = nextController
    }
    

}
