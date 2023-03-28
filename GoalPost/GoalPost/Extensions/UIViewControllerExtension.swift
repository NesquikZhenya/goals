//
//  UIViewControllerExtension.swift
//  GoalPost
//
//  Created by Евгений Михневич on 29.06.2022.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
//        let transition = CATransition()
//        transition.duration = 0.3
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromRight
//        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func presentSecondaryDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        
        guard let presentedViewController = presentedViewController else {return}
        
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
    }
    
//    func dismissDetail() {
//        let transition = CATransition()
//        transition.duration = 0.3
//        transition.type = .push
//        transition.subtype = .fromLeft
//        self.view.window?.layer.add(transition, forKey: kCATransition)
//        
//        dismiss(animated: false, completion: nil)
//    }
    
}
