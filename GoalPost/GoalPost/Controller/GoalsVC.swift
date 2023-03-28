//
//  ViewController.swift
//  GoalPost
//
//  Created by Евгений Михневич on 28.06.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {


    @IBOutlet weak var goalsTableView: UITableView!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
        self.fetch { complete in
            if complete {
                if goals.count >= 1 {
                    goalsTableView.isHidden = false
                } else {
                    goalsTableView.isHidden = true
                }
            }
        }
        self.goalsTableView.reloadData()
        print("view appeared!")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
        fetchCoreData()
        goalsTableView.reloadData()
        print("view appeared1!")
    }
    
    func fetchCoreData(){
        self.fetch { complete in
            if complete {
                if goals.count >= 1 {
                    goalsTableView.isHidden = false
                } else {
                    goalsTableView.isHidden = true
                }
            }
        }
    }

    @IBAction func addGoalButtonDidTap(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC")
            else {return }
        presentDetail(createGoalVC)
    }

    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = goalsTableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell
            else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { rowAction, indexPath in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { rowAction, indexPath in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.5610579252, green: 0.9148457646, blue: 0.8369702697, alpha: 1)
        
        return [deleteAction, addAction]
    }
}

extension GoalsVC {
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let manadexContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress += 1
        } else {
            return
        }
        
        do {
            try manadexContext.save()
            print("progress saved")
        } catch {
            debugPrint("can't save progress: \(error.localizedDescription)")
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContex = appDelegate?.persistentContainer.viewContext else {return}
        managedContex.delete(goals[indexPath.row])
        do {
            try managedContex.save()
            print("successfully removed goal")
        } catch {
            debugPrint("can't remove: \(error.localizedDescription)")
        }
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("data was fetched")
            completion(true)
        } catch {
            debugPrint("Can't fetch: \(error.localizedDescription)")
            completion(false)
        }
    
    }
    
    @IBAction func refreshBtn(_ sender: Any) {
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
        goalsTableView.reloadData()
        print("data reloaded!")

    }
}
 

