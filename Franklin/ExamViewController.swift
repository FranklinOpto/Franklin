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
    var userResponses: [Int] = []
    var userCorrectness: [Bool] = []
    var index : Int = 15
    var incorrectResponseStreak : Int = 0
    var correctResponseStreak : Int = 0
    var currentCorrectAngle : Int?
    var matchPoint : Bool = false
    
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
        updateImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func downButtonPressed(_ sender: Any) {
        userResponses.append(0)
        checkResponse()
    }
    
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        userResponses.append(1)
        checkResponse()
    }

    @IBAction func upButtonPressed(_ sender: Any) {
        userResponses.append(2)
        checkResponse()
    }

    @IBAction func rightButtonPressed(_ sender: Any) {
        userResponses.append(3)
        checkResponse()
    }
    
    @IBAction func unsureButtonPressed(_ sender: Any) {
        userResponses.append(-1)
        updateImage()
    }

    func updateImage(){
        if(0 <= index && index < imageScales.count){
            landoltC.image = UIImage(named: "\(imageName)\(imageScales[index])-S.png")
            var rotateScale = Int(arc4random_uniform(4))
            while(rotateScale != nil && rotateScale == currentCorrectAngle){
                rotateScale = Int(arc4random_uniform(4))
            }
            print(rotateScale)
            landoltC.transform = CGAffineTransform(rotationAngle: CGFloat(rotateScale)*CGFloat(M_PI)/2.0)
            currentCorrectAngle = rotateScale
        } else {
            print("Index moved out of available range")
        }
    }
    
    func checkResponse(){
        if(userResponses.last == currentCorrectAngle){
            print("Correct")
            incorrectResponseStreak = 0
            correctResponseStreak += 1
            if(!matchPoint){
                index -= 1
                updateImage()
            } else {
                if(correctResponseStreak >= 3){
                    print("Completed Exam")
                } else {
                    updateImage()
                }
            }
        } else {
            print("Wrong")
            correctResponseStreak = 0
            incorrectResponseStreak += 1
            if(incorrectResponseStreak >= 3){
                matchPoint = true
                index += 1
                updateImage()
            } else {
                updateImage()
            }
            
        }
        updateImage()
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
