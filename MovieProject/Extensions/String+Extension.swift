//
//  String+Extension.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 07/08/21.
//

import Foundation

extension String {
    /// Trim white space from string
    /// - Returns: String
    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
