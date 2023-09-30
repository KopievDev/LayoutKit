import UIKit

public struct LayoutKit {
    var view: UIView
    public init(view: UIView) {
        self.view = view
    }
}

public extension LayoutKit {
    enum Relation {
        case equal
        case lessOrEqual
        case greaterOrEqual
    }

    indirect enum Edge {
        case top(CGFloat)
        case left(CGFloat)
        case right(CGFloat)
        case bottom(CGFloat)
        case centerX(CGFloat)
        case centerY(CGFloat)
        case safeTop(CGFloat)
        case safeBottom(CGFloat)
        case spaceH(CGFloat)
        case spaceV(CGFloat)
        case padding(CGFloat)
        case safePadding(CGFloat)

        case multiplier(CGFloat, edge: Self)
        case relation(Relation, edge: Self)
        case priority(CGFloat, edge: Self)

        public static let top = Self.top(0)
        public static var left = Self.left(0)
        public static var right = Self.right(0)
        public static var bottom  = Self.bottom(0)
        public static var centerX  = Self.centerX(0)
        public static var centerY  = Self.centerY(0)
        public static var safeTop = Self.safeTop(0)
        public static var safeBottom = Self.safeBottom(0)
        public static var padding = Self.padding(0)
        public static var safePadding = Self.safePadding(0)

    }

    @discardableResult
    func pinTo(_ view: UIView, edges: Edge...) -> Self {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        edges.forEach { edge in pinTo(view, edge: edge) }
        return self
    }

    @discardableResult
    func pinTo(_ view: UIView, edges: [Edge]) -> Self {
        edges.forEach { edge in pinTo(view, edge: edge) }
        return self
    }


    private func pinTo(_ view: UIView, edge: Edge) {
        let mainView = self.view
        switch edge {
        case .top(let constant):
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        case .left(let constant):
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).isActive = true
        case .right(let constant):
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant).isActive = true
        case .bottom(let constant):
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
        case .centerX(let constant):
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        case .centerY(let constant):
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        case .spaceH(let constant):
            mainView.rightAnchor.constraint(equalTo: view.leftAnchor, constant: -constant).isActive = true
        case .spaceV(let constant):
            mainView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constant).isActive = true
        case .multiplier(let multiplier, edge: let edge):
            pinTo(view, edge: edge, multiplier: multiplier)
        case .relation(let relation, edge: let edge):
            pinTo(view, edge: edge, relation: relation)
        case .priority(let priority, edge: let edge):
            pinTo(view, edge: edge, priority: priority)
        case .safeBottom(let constant):
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant).isActive = true
        case .safeTop(let constant):
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
        case .padding(let constant):
            pinTo(view, edges: .top(constant), .left(constant), .right(constant), .bottom(constant))
        case .safePadding(let constant):
            pinTo(view, edges: .safeTop(constant), .left(constant), .right(constant), .safeBottom(constant))
        }
    }

    private func pinTo(_ view: UIView, edge: Edge, multiplier: CGFloat) {
        let mainView = self.view
        switch edge {
        case .top:
            mainView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: multiplier).isActive = true
        case .left:
            mainView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: multiplier).isActive = true
        case .right:
            mainView.rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor, multiplier: multiplier).isActive = true
        case .bottom:
            mainView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: multiplier).isActive = true
        case .centerX:
            mainView.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: multiplier).isActive = true
        case .centerY:
            mainView.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: multiplier).isActive = true
        case .spaceH:
            mainView.rightAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: multiplier).isActive = true
        case .spaceV:
            mainView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: multiplier).isActive = true
        case .multiplier(_, edge: _):
            fatalError("Can't be multiplier with multiplier")
        case .relation(_, edge: _):
            fatalError("Can't be relation with relation")
        case .priority(_, edge: _):
            fatalError("Didn't implemented priority attribute")
        case .safeTop:
            mainView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: multiplier).isActive = true
        case .safeBottom:
            mainView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: multiplier).isActive = true
        case .padding:
            mainView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: multiplier).isActive = true
            mainView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: multiplier).isActive = true
            mainView.rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor, multiplier: multiplier).isActive = true
            mainView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: multiplier).isActive = true
        case .safePadding:
            mainView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: multiplier).isActive = true
            mainView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: multiplier).isActive = true
            mainView.rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor, multiplier: multiplier).isActive = true
            mainView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: multiplier).isActive = true

        }
    }

    private func pinTo(_ view: UIView, edge: Edge, priority: CGFloat) {
        let mainView = self.view
        switch edge {
        case .top(let constant):
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).priority(priority).isActive = true
        case .left(let constant):
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).priority(priority).isActive = true
        case .right(let constant):
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant).priority(priority).isActive = true
        case .bottom(let constant):
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).priority(priority).isActive = true
        case .centerX(let constant):
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).priority(priority).isActive = true
        case .centerY(let constant):
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).priority(priority).isActive = true
        case .spaceH(let constant):
            mainView.rightAnchor.constraint(equalTo: view.leftAnchor, constant: -constant).priority(priority).isActive = true
        case .spaceV(let constant):
            mainView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constant).priority(priority).isActive = true
        case .multiplier(_, edge: _):
            fatalError("Didn't implemented multipier attribute")
        case .relation(_, edge: _):
            fatalError("Didn't implemented relation attribute")
        case .priority(_, edge: _):
            fatalError("Didn't implemented priority attribute")
        case .safeBottom(let constant):
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant).priority(priority).isActive = true
        case .safeTop(let constant):
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant).priority(priority).isActive = true
        case .padding(let constant):
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).priority(priority).isActive = true
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).priority(priority).isActive = true
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant).priority(priority).isActive = true
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).priority(priority).isActive = true
        case .safePadding(let constant):
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant).priority(priority).isActive = true
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).priority(priority).isActive = true
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant).priority(priority).isActive = true
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant).priority(priority).isActive = true
        }
    }

    private func pinTo(_ view: UIView, edge: Edge, relation: Relation) {
        let mainView = self.view
        switch relation {
        case .equal:
            fatalError("Use without relation")
        case .lessOrEqual:
            switch edge {
            case .top(let constant):
                mainView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: constant).isActive = true
            case .left(let constant):
                mainView.leftAnchor.constraint(lessThanOrEqualTo: view.leftAnchor, constant: constant).isActive = true
            case .right(let constant):
                mainView.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: -constant).isActive = true
            case .bottom(let constant):
                mainView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -constant).isActive = true
            case .centerX(let constant):
                mainView.centerXAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor, constant: constant).isActive = true
            case .centerY(let constant):
                mainView.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: constant).isActive = true
            case .spaceH(let constant):
                mainView.rightAnchor.constraint(lessThanOrEqualTo: view.leftAnchor, constant: -constant).isActive = true
            case .spaceV(let constant):
                mainView.bottomAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: -constant).isActive = true
            case .multiplier(_, edge: _):
                fatalError("Can't be multiplier with relation")
            case .relation(_, edge: _):
                fatalError("Can't be relation with relation")
            case .priority(_, edge: _):
                fatalError("Didn't implemented priority attribute")
            case .safeTop(let constant):
                mainView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor,
                                     constant: constant).isActive = true
            case .safeBottom(let constant):
                mainView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                                        constant: constant).isActive = true
            case .padding(let constant):
                mainView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: constant).isActive = true
                mainView.leftAnchor.constraint(lessThanOrEqualTo: view.leftAnchor, constant: constant).isActive = true
                mainView.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: -constant).isActive = true
                mainView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -constant).isActive = true
            case .safePadding(let constant):
                mainView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
                mainView.leftAnchor.constraint(lessThanOrEqualTo: view.leftAnchor, constant: constant).isActive = true
                mainView.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: -constant).isActive = true
                mainView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant).isActive = true
            }
        case .greaterOrEqual:
            switch edge {
            case .top(let constant):
                mainView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: constant).isActive = true
            case .left(let constant):
                mainView.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: constant).isActive = true
            case .right(let constant):
                mainView.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: -constant).isActive = true
            case .bottom(let constant):
                mainView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -constant).isActive = true
            case .centerX(let constant):
                mainView.centerXAnchor.constraint(greaterThanOrEqualTo: view.centerXAnchor, constant: constant).isActive = true
            case .centerY(let constant):
                mainView.centerYAnchor.constraint(greaterThanOrEqualTo: view.centerYAnchor, constant: constant).isActive = true
            case .spaceH(let constant):
                mainView.rightAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: -constant)
                    .isActive = true
            case .spaceV(let constant):
                mainView.bottomAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: -constant)
                    .isActive = true
            case .multiplier(_, edge: _):
                fatalError("Can't be multiplier with relation")
            case .relation(_, edge: _):
                fatalError("Can't be relation with relation")
            case .priority(_, edge: _):
                fatalError("Didn't implemented priority attribute")
            case .safeTop(let constant):
                mainView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor,
                                     constant: constant).isActive = true
            case .safeBottom(let constant):
                mainView.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                                        constant: constant).isActive = true
            case .padding(let constant):
                mainView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: constant).isActive = true
                mainView.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: constant).isActive = true
                mainView.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: -constant).isActive = true
                mainView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -constant).isActive = true
            case .safePadding(let constant):
                mainView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: constant).isActive = true
                mainView.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: constant).isActive = true
                mainView.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: -constant).isActive = true
                mainView.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant).isActive = true

            }
        }
    }

    enum LayoutDimension { case width, height }

    func width(_ view: UIView, equalTo size: LayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0)  {
        let mainView = self.view
        switch size {
        case .width:
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                   multiplier: multiplier,
                                   constant: constant).isActive = true
        case .height:
            mainView.widthAnchor.constraint(equalTo: view.heightAnchor,
                                   multiplier: multiplier,
                                   constant: constant).isActive = true
        }
    }

    func height(_ view: UIView, equalTo size: LayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0)  {
        let mainView = self.view
        switch size {
        case .width:
            mainView.heightAnchor.constraint(equalTo: view.widthAnchor,
                                    multiplier: multiplier,
                                    constant: constant).isActive = true
        case .height:
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                    multiplier: multiplier,
                                    constant: constant).isActive = true
        }
    }

    func addSubview(_ view: UIView, edges: Edge...) {
        if view.superview != self.view { self.view.addSubview(view) }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layout.pinTo(self.view, edges: edges)
    }

    func addConstraint(width: CGFloat? = nil, height: CGFloat? = nil) {
        if let width = width {
            let constraint = view.widthAnchor.constraint(equalToConstant: width)
            constraint.priority = UILayoutPriority(999)
            constraint.isActive = true
        }
        if let height = height {
            let constraint = view.heightAnchor.constraint(equalToConstant: height)
            constraint.priority = UILayoutPriority(999)
            constraint.isActive = true
        }
        guard view.constraints.count > 0 else { return }
        view.addConstraints(view.constraints)
    }

}

public extension UIView {
    var layout: LayoutKit { LayoutKit(view: self) }
    var lyt: LayoutKit { LayoutKit(view: self) }

    @discardableResult
    func size(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        lyt.addConstraint(width: width, height: height)
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        return self
    }

    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }

    @discardableResult
    func isHidden(_ hidden: Bool) -> Self {
        self.isHidden = hidden
        return self
    }

    @discardableResult
    func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }

    @discardableResult
    func withInteraction(_ enabled: Bool = true) -> Self {
        isUserInteractionEnabled = enabled
        return self
    }

    func asImage() -> UIImage {
        UIGraphicsImageRenderer(bounds: bounds).image { layer.render(in: $0.cgContext) }
    }


    @discardableResult
    func hugging(_ priority: Float = 1000, for axis: NSLayoutConstraint.Axis = .vertical) -> Self {
        setContentHuggingPriority(UILayoutPriority(rawValue: priority), for: axis)
        return self
    }

    @discardableResult
    func resistance(_ priority: Float = 1000, for axis: NSLayoutConstraint.Axis = .vertical) -> Self {
        setContentCompressionResistancePriority(UILayoutPriority(rawValue: priority), for: axis)
        return self
    }

    @discardableResult
    func borderColor(_ color: UIColor) -> Self {
        layer.borderColor = color.cgColor
        return self
    }

    @discardableResult
    func bordeWidth(_ width: CGFloat) -> Self {
        layer.borderWidth = width
        return self
    }

    @discardableResult
    func with(id: String) -> Self {
        accessibilityIdentifier = id
        return self
    }
    @discardableResult
    func with(tag: Int) -> Self {
        self.tag = tag
        return self
    }

}

public extension NSLayoutConstraint {
    @discardableResult
    func priority(_ priority: CGFloat) -> Self {
        self.priority = UILayoutPriority(Float(priority))
        return self
    }

}
