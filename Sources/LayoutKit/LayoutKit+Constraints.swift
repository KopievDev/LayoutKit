//
//  File.swift
//  
//
//  Created by Иван Копиев on 25.09.2023.
//

import UIKit

extension LayoutKit {

    var layoutConstraintTop: NSLayoutConstraint? {
        guard let superview = view.superview else { return nil }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == view, constraint.firstAttribute == .top {
                return constraint
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == view, constraint.secondAttribute == .top {
                return constraint
            }
        }
        return nil
    }

    var layoutConstraintLeft: NSLayoutConstraint? {
        guard let superview = view.superview else { return nil }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == view,
                (constraint.firstAttribute == .leading || constraint.firstAttribute == .left) {
                return constraint
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == view,
                (constraint.secondAttribute == .leading || constraint.secondAttribute == .left) {
                return constraint
            }
        }
        return nil
    }

    var layoutConstraintRight: NSLayoutConstraint? {
        guard let superview = view.superview else { return nil }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == view,
               (constraint.firstAttribute == .trailing || constraint.firstAttribute == .right){
                return constraint
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == view,
               (constraint.secondAttribute == .trailing || constraint.secondAttribute == .right){
                return constraint
            }
        }
        return nil
    }

    var layoutConstraintBottom: NSLayoutConstraint? {
        guard let superview = view.superview else { return nil }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == view, constraint.firstAttribute == .bottom {
                return constraint
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == view, constraint.secondAttribute == .bottom {
                return constraint
            }
        }
        return nil
    }

    var layoutConstraintHeight: NSLayoutConstraint? {
        for constraint in view.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == view, constraint.firstAttribute == .height, constraint.secondItem == nil {
                return constraint
            }
        }
        if let superview = view.superview {
            for constraint in superview.constraints {
                if let firstItem = constraint.firstItem as? UIView, firstItem == view, constraint.firstAttribute == .height, constraint.secondItem == nil {
                    return constraint
                }
            }
        }
        return nil
    }

    var layoutConstraintWidth: NSLayoutConstraint? {
        for constraint in view.constraints {
            guard String(describing: type(of: constraint)) == "NSLayoutConstraint" else { continue }
            if let firstItem = constraint.firstItem as? UIView, firstItem == view, constraint.firstAttribute == .width {
                return constraint
            }
        }
        if let superview = view.superview {
            for constraint in superview.constraints {
                guard String(describing: type(of: constraint)) == "NSLayoutConstraint" else { continue }
                if let firstItem = constraint.firstItem as? UIView, firstItem == view, constraint.firstAttribute == .width {
                    return constraint
                }
            }
        }
        return nil
    }

    func setConstraint(top : CGFloat) {
        layoutConstraintTop?.constant = top
    }

    func setConstraint(left : CGFloat) {
        layoutConstraintLeft?.constant = left
    }

    func setConstraint(right : CGFloat) {
        layoutConstraintRight?.constant = right
    }

    func setConstraint(bottom : CGFloat){
        layoutConstraintBottom?.constant = bottom
    }

    func setConstraint(width : CGFloat){
        if let layoutConstraintWidth = layoutConstraintWidth {
            layoutConstraintWidth.constant = width
        } else {
            addConstraint(width: width)
        }
    }

    func setConstraint(height : CGFloat){
        if let layoutConstraintHeight = layoutConstraintHeight {
            layoutConstraintHeight.constant = height
        } else {
            addConstraint(height: height)
        }
    }

    var constraintTop: CGFloat {
        return layoutConstraintTop?.constant ?? 0
    }

    var constraintLeft: CGFloat {
        return layoutConstraintLeft?.constant ?? 0
    }

    var constraintRight: CGFloat{
        return layoutConstraintRight?.constant ?? 0
    }

    var constraintBottom: CGFloat{
        return layoutConstraintBottom?.constant ?? 0
    }

    var constraintWidth: CGFloat{
        return layoutConstraintWidth?.constant ?? 0
    }

    var constraintHeight: CGFloat{
        return layoutConstraintHeight?.constant ?? 0
    }

    func setConstraint(left : CGFloat? = nil, top: CGFloat? = nil, right : CGFloat? = nil, bottom : CGFloat? = nil) {
        if let left = left { setConstraint(left: left) }
        if let top = top { setConstraint(top: top) }
        if let bottom = bottom { setConstraint(bottom: bottom) }
        if let right = right { setConstraint(right: right) }
    }

    func setConstraint(centerY : CGFloat){
        guard let superview = view.superview else { return }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == view, constraint.firstAttribute == .centerY {
                constraint.constant = centerY
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == view, constraint.secondAttribute == .centerY {
                constraint.constant = centerY
            }
        }
    }

    func constraint(_ attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint?{
        guard let superview = view.superview else { return nil }

        var check = attribute
        if check == .left { check = .leading }
        if check == .right { check = .trailing }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == view, constraint.firstAttribute == check {
                return constraint
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == view, constraint.secondAttribute == check {
                return constraint
            }
        }
        return nil
    }

    func constraintCenterY() -> CGFloat {
        guard let superview = view.superview else { return 0 }
        for constraint in superview.constraints {
            if let firstItem = constraint.firstItem as? UIView, firstItem == view, constraint.firstAttribute == .centerY {
                return constraint.constant
            }
            if let secondItem = constraint.secondItem as? UIView, secondItem == view, constraint.secondAttribute == .centerY {
                return constraint.constant
            }
        }
        return 0
    }

    func addConstraint(width: CGFloat) {
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func addConstraint(height: CGFloat) {
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func addConstraint(view: UIView,
                       left: CGFloat? = nil, right: CGFloat? = nil,
                       top: CGFloat? = nil, bottom: CGFloat? = nil,
                       width: CGFloat? = nil, height: CGFloat? = nil,
                       centerX: CGFloat? = nil, centerY: CGFloat? = nil) {

        let mainView = self.view
        var constraints = [NSLayoutConstraint]()
        if let left = left { constraints.append(mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -left)) }
        if let right = right { constraints.append(mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: right)) }
        if let top = top { constraints.append(view.topAnchor.constraint(equalTo: mainView.topAnchor, constant: top)) }
        if let bottom = bottom { constraints.append(mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)) }
        if let width = width { constraints.append(view.widthAnchor.constraint(equalToConstant: width)) }
        if let height = height { constraints.append(view.heightAnchor.constraint(equalToConstant: height)) }
        if let centerX = centerX { constraints.append(mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: centerX)) }
        if let centerY = centerY { constraints.append(mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY)) }
        guard constraints.count > 0 else { return }
        view.addConstraints(constraints)
    }
}
