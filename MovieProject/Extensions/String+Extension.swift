//
//  String+Extension.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 07/08/21.
//

import Foundation

extension String {
    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
