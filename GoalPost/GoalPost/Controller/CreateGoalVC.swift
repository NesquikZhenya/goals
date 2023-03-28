//
//  CreateGoalVC.swift
//  GoalPost
//
//  Created by Евгений Михневич on 29.06.2022.
//

import UIKit
import CoreData

class CreateGoalVC: UIViewController {


    
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func shortTermButtonDidTap(_ sender: Any) {
        goalType = .shortTerm
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
    }
    
    
    @IBAction func longTermButtonDidTap(_ sender: Any) {
        goalType = .longTerm
        shortTermButton.setDeselectedColor()
        longTermButton.setSelectedColor()
    }
    
    @IBAction func nextButtonDidTap(_ sender: Any) {
        if goalTextField.text != "" && goalTextField.text != "What's your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {return}
            finishGoalVC.initData(description: goalTextField.text!, type: goalType)
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
