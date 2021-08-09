//
//  UIImageView+Extension.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 07/08/21.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    /// Set URL in ImageView
    /// - Parameter url: URL as string
    func setPoster(_ url: String?) {
        guard let urlStr = url,
              let tempURL = URL(string: urlStr) else { return }
        self.sd_setImage(with: tempURL, completed: nil)
    }
}

