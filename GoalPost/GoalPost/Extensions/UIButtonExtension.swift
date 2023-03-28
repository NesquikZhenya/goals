//
//  UIButtonExtension.swift
//  GoalPost
//
//  Created by Евгений Михневич on 29.06.2022.
//

import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.07894492894, green: 0.9550567269, blue: 0.5466635227, alpha: 1)
    }
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.6691151261, green: 0.9268799424, blue: 0.7803397775, alpha: 1)
    }
}
