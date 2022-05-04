//
//  ViewController+Extensions.swift
//  ZemogaTest
//
//  Created by Dennis.Mostajo on 5/3/22.
//

import UIKit

/// Custom `Extension` from `UIViewController`.
extension UIViewController {
    /// Custom `Struct`to define constant values on `Navigation Bar`.
    struct Uniform {
        static let simple = 1.0
        static let tiny:CGFloat = -8
        static let small:CGFloat = 5
        static let rightNavigationButtonSize: CGSize = CGSize(width: 35, height: 35)
        static let customBackButtonSize: CGSize = CGSize(width: 35, height: 35)
    }
    
    /// Custom method to configure the `Navigation Bar`.
    func setupNavigation(title: String?, leftButton: UIButton?, rightButton: UIButton?, secondRightButton: UIButton?, tint: UIColor?, background: UIColor?) {
        self.title = title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.sizeToFit()
        self.navigationController?.navigationBar.barTintColor = tint
        self.navigationController?.navigationBar.backgroundColor = background
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = background
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        if let rightButton = rightButton {
            self.navigationController?.navigationBar.addSubview(rightButton)
            let widthConstraint = NSLayoutConstraint(
                item: rightButton,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: Uniform.simple,
                constant: Uniform.rightNavigationButtonSize.width
            )
            
            let heightConstraint = NSLayoutConstraint(
                item: rightButton,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: Uniform.simple,
                constant: Uniform.rightNavigationButtonSize.height
            )
            
            let bottomConstraint = NSLayoutConstraint(
                item: rightButton,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: self.navigationController?.navigationBar,
                attribute: .bottom,
                multiplier: Uniform.simple,
                constant: Uniform.tiny
            )
            
            let rightConstraint = NSLayoutConstraint(
                item: rightButton,
                attribute: .right,
                relatedBy: .equal,
                toItem: self.navigationController?.navigationBar,
                attribute: .right,
                multiplier: Uniform.simple,
                constant: Uniform.tiny)
            rightButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([rightConstraint, bottomConstraint, widthConstraint, heightConstraint])
        }
        
        if let secondRightButton = secondRightButton {
            self.navigationController?.navigationBar.addSubview(secondRightButton)
            let widthConstraint = NSLayoutConstraint(
                item: secondRightButton,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: Uniform.simple,
                constant: Uniform.rightNavigationButtonSize.width
            )
            
            let heightConstraint = NSLayoutConstraint(
                item: secondRightButton,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: Uniform.simple,
                constant: Uniform.rightNavigationButtonSize.height
            )
            
            let bottomConstraint = NSLayoutConstraint(
                item: secondRightButton,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: self.navigationController?.navigationBar,
                attribute: .bottom,
                multiplier: Uniform.simple,
                constant: Uniform.tiny
            )
            
            let rightConstraint = NSLayoutConstraint(
                item: secondRightButton,
                attribute: .right,
                relatedBy: .equal,
                toItem: rightButton,
                attribute: .right,
                multiplier: Uniform.simple,
                constant: Uniform.tiny - Uniform.rightNavigationButtonSize.width)
            secondRightButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([rightConstraint, bottomConstraint, widthConstraint, heightConstraint])
        }
        
        if let leftButton = leftButton {
            self.navigationController?.navigationBar.addSubview(leftButton)
            let widthConstraint = NSLayoutConstraint(
                item: leftButton,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: Uniform.simple,
                constant: Uniform.rightNavigationButtonSize.width
            )
            
            let heightConstraint = NSLayoutConstraint(
                item: leftButton,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: Uniform.simple,
                constant: Uniform.rightNavigationButtonSize.height
            )
            
            let topConstraint = NSLayoutConstraint(
                item: leftButton,
                attribute: .top,
                relatedBy: .equal,
                toItem: self.navigationController?.navigationBar,
                attribute: .top,
                multiplier: Uniform.simple,
                constant: Uniform.small
            )
            
            let leftConstraint = NSLayoutConstraint(
                item: leftButton,
                attribute: .left,
                relatedBy: .equal,
                toItem: self.navigationController?.navigationBar,
                attribute: .left,
                multiplier: Uniform.simple,
                constant: Uniform.small)
            leftButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([leftConstraint, topConstraint, widthConstraint, heightConstraint])
        }
    }
}
