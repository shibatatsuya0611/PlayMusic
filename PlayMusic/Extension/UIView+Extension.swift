//
//  UIView+Extension.swift
//  PlayMusic
//
//  Created by Xuan Huy on 6/8/20.
//  Copyright © 2020 Xuan Huy. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    // MARK: set background image
    func setBackgroundImage(image: String?) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: image!)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        backgroundImage.clipsToBounds = true
        self.insertSubview(backgroundImage, at: 0)
    }
    // constraints follow superview --> fill over supperview
    func fillSuperview() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    // support constraints for size
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    // support constraints
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    // addc
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    // MARK: remove all contraint
    func removeAllConstraints() {
        self.removeConstraints(self.constraints)
        for view in self.subviews {
            view.removeAllConstraints()
        }
    }
    
    // MARK: get parent view controller
    /// Get Parent View Controller from any view
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as? UIViewController
            }
        }
        return nil
    }
}

extension UIView
{
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func makeBottomShadow(shadowHeight: CGFloat = 5, opacity: Float = 0.7) {
        let shadowPath = UIBezierPath()
        
        shadowPath.move(to: CGPoint(x: bounds.origin.x, y: frame.size.height))
        shadowPath.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height + shadowHeight))
        shadowPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        shadowPath.close()
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.backgroundColor = UIColor.clear.cgColor
        layer.masksToBounds = false
        layer.shadowOpacity = opacity
        layer.shadowPath = shadowPath.cgPath
        layer.shadowRadius = 4
    }
    
    func makeBottomShadow(shadowColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25), shadowOffset: CGSize = CGSize(width: 0.0, height: 1.5), shadowOpacity: Float, shadowRadius: CGFloat, radius: CGFloat) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    /// show loading in view
    func displaySpinner() -> UIView {
        let spinnerView = UIView.init(frame: self.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    // hide loading view
    func removeSpinner(spinner : UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    func addBorderWithContraint(color: UIColor, bottomHeight: CGFloat?, rightWidth: CGFloat?, leftWidth: CGFloat?, topHeight: CGFloat?) {
        if let bottomH = bottomHeight, bottomH > 0 {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = color
            self.addSubview(v)
            v.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: bottomH))
        }
        if let rightW = rightWidth, rightW > 0 {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = color
            self.addSubview(v)
            v.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: rightW, height: 0))
        }
        if let leftW = leftWidth, leftW > 0 {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = color
            self.addSubview(v)
            v.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .zero, size: .init(width: leftW, height: 0))
        }
        if let topH = topHeight, topH > 0 {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = color
            self.addSubview(v)
            v.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: topH))
        }
    }
}


extension UIView {
    func hideKeyBoardWhenTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doneButtonAction))
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func doneButtonAction() {
        self.endEditing(true)
    }
}
