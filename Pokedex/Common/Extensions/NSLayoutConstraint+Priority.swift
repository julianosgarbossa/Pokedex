//
//  NSLayoutConstraint+Priority.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 19/06/25.
//

import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
