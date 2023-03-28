//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Евгений Михневич on 29.06.2022.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController {

    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var createGoalButton: UIButton!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType){
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButtonDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createGoalButtonDidTap(_ sender: Any) {
        if pointsTextField.text != nil {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func save(completion: (_ finished: Bool)-> ()) {
        guard let managedContex = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedContex)
        goal.goalType = goalType.rawValue
        goal.goalDescription = goalDescription
        goal.goalCompletionValue = Int32(pointsTextField.text ?? "0") ?? 0
        goal.goalProgress = Int32(0)
        
        do {
            try managedContex.save()
            print("Saved!")
            completion(true)
        } catch {
            debugPrint("Can't save: \(error.localizedDescription)")
            completion(false)
        }
    }
}
