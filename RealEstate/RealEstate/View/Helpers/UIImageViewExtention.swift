//
//  Extentions.swift
//  RealEstate
//
//  Created by Alaa Khalil on 08/01/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageWithURL(url: URL, placeHolderImage placeholder: UIImage?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url,
                         placeholder: placeholder,
                         options: [.transition(.fade(1))],
                         progressBlock: nil) { (result) in
                            switch result {
                            case .success(let value):
                                self.image = value.image
                            case .failure(let error):
                                print("KingFisher Job failed: \(error.localizedDescription)")
            }
        }
    }
}
