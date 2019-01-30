//
//  String.swift
//  AutentiaScrumCards
//
//  Created by Anton Zuev on 30/01/2019.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
