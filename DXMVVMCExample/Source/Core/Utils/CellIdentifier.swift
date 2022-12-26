//
//  CellIdentifier.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 8/13/22.
//

import Foundation
import UIKit

protocol CellIdentifier {
    static func identifier() -> String
}

extension CellIdentifier where Self: UITableViewCell {
    static func identifier() -> String {
        let fullName = NSStringFromClass(self)

        let className = fullName.components(separatedBy: ".")[1]

        return className
    }
}
