//
//  ResultsViewController.swift
//  Franklin
//
//  Created by Takashi Wickes on 2/28/17.
//  Copyright © 2017 Franklin. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var prescription: [String] = [String]()

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(prescription)
        // Do any additional setup after loading the view.
        if(prescription.count == 2)
        {
            leftLabel.text = prescription[0]
            rightLabel.text = prescription[1]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "resetExam", sender: self)
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
