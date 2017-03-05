//
//  SelectionViewController.swift
//  Franklin
//
//  Created by Takashi Wickes on 3/4/17.
//  Copyright © 2017 Franklin. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonVersionPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "buttonVersionChosen", sender: self)
    }

    @IBAction func gestureVersionPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gestureVersionChosen", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
          let nextController: ExamViewController = segue.destination as! ExamViewController
        if(segue.identifier == "buttonVersionChosen"){
            nextController.inputType = "button"
        } else if (segue.identifier == "gestureVersionChosen"){
            nextController.inputType = "gesture"
        }
    }
    

}
