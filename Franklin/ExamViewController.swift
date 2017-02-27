//
//  ExamViewController.swift
//  Franklin
//
//  Created by Jacob Ville on 2/27/17.
//  Copyright © 2017 Franklin. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController {
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
