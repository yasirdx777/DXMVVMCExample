//
//  CellIdentifier.swift
//  DXCats
//
//  Created by iQ on 8/13/22.
//

import Foundation
import UIKit

protocol CellIdentifier {
    static func identifier() -> String
}

extension CellIdentifier where Self: UITableViewCell {
    static func identifier() -> String {
        /// this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        /// this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        return className
    }
}
