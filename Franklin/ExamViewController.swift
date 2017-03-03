//
//  ExamViewController.swift
//  Franklin
//
//  Created by Jacob Ville on 2/27/17.
//  Copyright © 2017 Franklin. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var rightDone: Bool?
    var leftDone: Bool?
    var prescription: [String] = [String]()
//    var prescriptionToSend: [String] = [String]()
    
    // MARK: Exam Prescription Constants
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
        "200": "-3.50",
        "240": "-3.75",
        "300": "-4.00"
    ]
    
    // MARK: Instance Data
    var userResponses: [Int] = []
    var userCorrectness: [Bool] = []
    var index : Int = 15
    var incorrectResponseStreak : Int = 0
    var correctResponseStreak : Int = 0
    var currentCorrectAngle : Int?
    var matchPoint : Bool = false
    
    // MARK: IB Outlets
    @IBOutlet weak var landoltC: UIImageView!
    @IBOutlet weak var landoltCWidth: NSLayoutConstraint!
    @IBOutlet weak var landoltCHeight: NSLayoutConstraint!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var unsureButton: UIButton!
    @IBOutlet weak var examView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var directionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if(leftDone != true){
            buttonView.transform = CGAffineTransform(translationX: buttonView.frame.width + 7, y: 0)
            examView.transform = CGAffineTransform(translationX: -(examView.frame.width + 7), y: 0)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTaps))
        tap.delegate = self
        buttonView.addGestureRecognizer(tap)
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
        for direction in directions {
            let userInputGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            userInputGesture.direction = direction
            buttonView.addGestureRecognizer(userInputGesture)
        }
        
        // Do any additional setup after loading the view.
        directionLabel.text = ""
        updateImage()
    }
    func handleTaps(sender: UISwipeGestureRecognizer){
        self.unsureButtonPressed(Any)
        directionLabelChange(message: "Unsure")
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                directionLabelChange(message: "Right")
                print("Swiped right")
                self.rightButtonPressed(Any)
            case UISwipeGestureRecognizerDirection.down:
                directionLabelChange(message: "Down")
                print("Swiped down")
                self.downButtonPressed(Any)
            case UISwipeGestureRecognizerDirection.left:
                directionLabelChange(message: "Left")
                print("Swiped left")
                self.leftButtonPressed(Any)
            case UISwipeGestureRecognizerDirection.up:
                directionLabelChange(message: "Up")
                print("Swiped up")
                self.upButtonPressed(Any)
            default:
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Button Events
    
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
        checkResponse()
    }
    
    func directionLabelChange(message: String){
        directionLabel.text = message
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.dismissLabel), userInfo: nil, repeats: false)
    }
    
    func dismissLabel(){
        directionLabel.text = ""
    }
    
    // MARK: - Exam Handling

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
                    evaluatePrescription()
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
    }
    
    func evaluatePrescription(){
        print("Prescription: \(index)")

        if(leftDone == nil){
            self.performSegue(withIdentifier: "performNextEye", sender: self)
        } else if (leftDone == true) {
            self.performSegue(withIdentifier: "showPrescription", sender: self)
        }
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let eyeValue : String = imageScales[index]
        
        if(segue.identifier == "performNextEye"){
            let nextController: EyeCoverInstructionViewController = segue.destination as! EyeCoverInstructionViewController
            nextController.leftDone = true
            nextController.rightDone = self.rightDone
            nextController.prescription.append(prescriptionConversion[eyeValue]!)
        } else if(segue.identifier == "showPrescription") {
            let nextController: ResultsViewController = segue.destination as! ResultsViewController
            nextController.prescription = self.prescription
            nextController.prescription.append(prescriptionConversion[eyeValue]!)
        }
    }

}
