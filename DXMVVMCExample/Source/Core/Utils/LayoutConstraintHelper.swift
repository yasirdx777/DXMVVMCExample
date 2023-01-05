//
//  LayoutConstraint.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 8/13/22.
//

import Foundation
import UIKit


extension UIView {
    func constraintsForAnchoringTo(boundsOf view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
}

extension NSLayoutConstraint {
    func usingPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

extension UILayoutPriority {
    static var almostRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 999)
    }
    
    static var notRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 0)
    }
}

@propertyWrapper
public struct UsesAutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}

