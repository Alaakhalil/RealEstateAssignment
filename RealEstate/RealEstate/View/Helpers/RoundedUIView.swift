//
//  RoundedUIView.swift
//  RealEstate
//
//  Created by Alaa Khalil on 06/01/2022.
//

import UIKit

@IBDesignable
class RoundUIView: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
