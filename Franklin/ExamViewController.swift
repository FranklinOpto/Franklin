//
//  ExamViewController.swift
//  Franklin
//
//  Created by Jacob Ville on 2/27/17.
//  Copyright © 2017 Franklin. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController {
    
    //Exam Prescription Constants
    var imageName: String = "Landolt_"
    var imageScales: [String] = ["20" , "25", "30", "40", "50", "60", "70", "80", "90", "100", "120", "140", "180", "200", "240", "300"]
    var prescriptionConversion: [String: String] = [
        "20": "0.00",
        "25": "-.50",
        "30": "-0.75",
        "40": "-1.00",
        "50": "-1.25",
        "60": "-1.50",
        "70": "-1.75",
        "80": "-2.00",
        "90": "-2.25",
        "100": "-2.50",
        "120": "-2.75",
        "140": "-3.00",
        "180": "-3.25",
        "200": "-3.50'",
        "240": "-3.75",
        "300": "-4.00"
    ]
    
    // Instance Data
    var userResponses: [String] = []
    
    // IB Outlets
    @IBOutlet weak var landoltC: UIImageView!
    @IBOutlet weak var landoltCWidth: NSLayoutConstraint!
    @IBOutlet weak var landoltCHeight: NSLayoutConstraint!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var unsureButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        userResponses.append("left")
        updateImage()
    }

    @IBAction func upButtonPressed(_ sender: Any) {
        userResponses.append("up")
        updateImage()
    }

    @IBAction func downButtonPressed(_ sender: Any) {
        userResponses.append("down")
        updateImage()
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        userResponses.append("right")
        updateImage()
    }
    
    @IBAction func unsureButtonPressed(_ sender: Any) {
        userResponses.append("unsure")
        updateImage()
    }

    func updateImage(){
//        landoltC.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//        landoltC.transform.rotated(by: CGFloat.pi/2)
        
//        landoltC.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        
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
