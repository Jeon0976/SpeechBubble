//
//  SpeechBubbleView.swift
//  SpeechBubble
//
//  Created by 전성훈 on 4/26/24.
//

import UIKit

public class SpeechBubbleView: UIView {
    
    public var text: String {
        didSet {
            textLabelView.text = text
            
            setConstraints(with: arrowPosition)
            
            if text.count > 1 {
                arrowView.positionRatio = arrowPositionRatio
            } else {
                arrowView.positionRatio = 0.5
            }
        }
    }
    
    public var font: UIFont {
        didSet {
            textLabelView.font = font
        }
    }
    
    public var textColor: UIColor {
        didSet {
            textLabelView.textColor = textColor
        }
    }
    
    public var textInset: CGFloat {
        didSet {
            textLabelView.textInset = textInset
        }
    }
    
    public var numberOfLines: Int {
        didSet {
            textLabelView.numberOfLines = numberOfLines
            
            setConstraints(with: arrowPosition)
        }
    }
    
    public var textAlignment: NSTextAlignment {
        didSet {
            textLabelView.textAlignment = textAlignment
            
            setConstraints(with: arrowPosition)
        }
    }

    public var arrowSize: CGFloat {
        didSet {
            arrowView.arrowSize = arrowSize
            
            setConstraints(with: arrowPosition)
        }
    }
    
    public var arrowPosition: SpeechBubbleArrowPosition {
        didSet {
            arrowView.arrowPosition = arrowPosition
            setConstraints(with: arrowPosition)
            
            if style.contains(.dottedLine) {
                textLabelView.updateDottedBorder()
            }
        }
    }
    
    public var arrowPositionRatio: CGFloat {
        didSet {
            arrowView.positionRatio = arrowPositionRatio
        }
    }
    
    private var _filledColor: UIColor = .white
    public var filledColor: UIColor {
        get {
            return _filledColor
        }
        
        set {
            _filledColor = newValue
            textLabelView.filledColor = filledColor
            arrowView.filledColor = filledColor
        }
    }
    
    private var _borderColor: UIColor = .clear
    public var borderColor: UIColor {
        get {
            return _borderColor
        }
        
        set {
            _borderColor = newValue
            textLabelView.borderColor = borderColor
            arrowView.borderColor = borderColor
        }
    }
    
    private var _borderWidth: CGFloat = 0
    public var borderWidth: CGFloat {
        get {
            return _borderWidth
        }
        
        set {
            _borderWidth = newValue
            arrowView.borderWidth = borderWidth
            textLabelView.borderWidth = borderWidth
        }
    }
    
    public var style: SpeechBubbleStyleOptions {
        didSet {
            arrowView.style = style
            textLabelView.style = style
            
            updateViewLayoutOrder()
            self.layoutIfNeeded()
        }
    }
    
    public override var clipsToBounds: Bool {
        didSet {
            textLabelView.clipsToBounds = clipsToBounds

            super.clipsToBounds = false
        }
    }
    
    public var cornerRadious: CGFloat {
        didSet {
            textLabelView.layer.cornerRadius = cornerRadious
        }
    }
    
    private var textLabelTopConstraint: NSLayoutConstraint?
    private var textLabelBottomConstraint: NSLayoutConstraint?
    private var textLabelLeadingConstraint: NSLayoutConstraint?
    private var textLabelTrailingConstraint: NSLayoutConstraint?
    
    private var arrowWidthConstraint: NSLayoutConstraint?
    private var arrowHeightConstraint: NSLayoutConstraint?
    private var arrowTopConstraint: NSLayoutConstraint?
    private var arrowBottomConstraint: NSLayoutConstraint?
    private var arrowLeadingConstraint: NSLayoutConstraint?
    private var arrowTrailingConstraint: NSLayoutConstraint?
    
    private var afterInitSetConstraint: Bool = false
    
    private var textLabelView: TextLabelView!
    private var arrowView: ArrowView!
    
    /// Creates a `SpeechBubbleView` with various customization options
    /// - Parameters:
    ///   - text: The text to display inside the speech bubble.
    ///   - font: The font of the text. Default is system font of size 16, medium weight.
    ///   - numberOfLines: The maximum number of lines for the text. Default is 0 (no limit).
    ///   - textAlignment: The alignment of the text within the speech bubble. Default is centered.
    ///   - textColor: The color of the text. Default is the label color.
    ///   - textInset: The padding inside the speech bubble around the text. Default is 16 points.
    ///   - filledColor: The background color of the speech bubble. Default is system grouped background.
    ///   - borderColor: The color of the speech bubble's border. Default is the separator color.
    ///   - borderWidth: The width of the border of the speech bubble. Default is 2 points.
    ///   - style: The styling options for the speech bubble, e.g., filled, lined, dotted.
    ///   - clipsToBounds: A Boolean value that determines whether subviews are confined to the bounds of the view. Default is true.
    ///   - cornerRadious: The radius of the corners of the speech bubble. Default is 15 points.
    ///   - arrowSize: The size of the arrow pointing from the speech bubble. Default is 10 points.
    ///   - arrowPosition: The position of the arrow (top, bottom, left, right).
    ///   - arrowPositionRatio: The position of the arrow along the specified edge as a ratio of the view's dimension. Default is 0.5.
    public init(
        text: String,
        font: UIFont = .systemFont(ofSize: 16, weight: .medium),
        numberOfLines: Int = 0,
        textAlignment: NSTextAlignment = .center,
        textColor: UIColor = .label,
        textInset: CGFloat = 16,
        filledColor: UIColor = .systemGroupedBackground,
        borderColor: UIColor = .separator,
        borderWidth: CGFloat = 2,
        style: SpeechBubbleStyleOptions,
        clipsToBounds: Bool = true,
        cornerRadious: CGFloat = 15,
        arrowSize: CGFloat = 10,
        arrowPosition: SpeechBubbleArrowPosition,
        arrowPositionRatio: CGFloat = 0.5
    ) {
        self.arrowView = ArrowView(
            arrowSize: arrowSize,
            arrowPosition: arrowPosition,
            positionRatio: text.count > 1 ? arrowPositionRatio: 0.5,
            style: style,
            filledColor: filledColor,
            borderColor: borderColor,
            borderWidth: borderWidth
        )
        
        self.textLabelView = TextLabelView(
            text: text,
            font: font,
            numberOfLines: numberOfLines,
            textAlignment: textAlignment,
            textColor: textColor,
            textInset: textInset,
            style: style,
            filedColor: filledColor,
            borderColor: borderColor,
            borderWidth: borderWidth,
            clipsToBounds: clipsToBounds,
            cornerRadious: cornerRadious
        )
        
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.textInset = textInset
        self.cornerRadious = cornerRadious
        self.arrowSize = arrowSize
        self.arrowPosition = arrowPosition
        self.arrowPositionRatio = arrowPositionRatio
        self.style = style
                
        super.init(frame: .zero)

        self.filledColor = filledColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.arrowView.backgroundColor = .clear
        
        setLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !afterInitSetConstraint {
            
            afterInitSetConstraint.toggle()
            setConstraints(with: arrowPosition)
        }
    }
    
    private func setLayout() {
        [
            textLabelView,
            arrowView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
    
    private func setConstraints(with arrowPosition: SpeechBubbleArrowPosition) {
        switch arrowPosition {
        case .top:
            setConstraintWhenTop()
        case .bottom:
            setConstraintWhenBottom()
        case .left:
            setConstraintWhenLeft()
        case .right:
            setConstraintWhenRight()
        }
    }
        
    private func setConstraintWhenTop() {
        setDeactiveConstraint()
        
        textLabelBottomConstraint = textLabelView.bottomAnchor.constraint(
            equalTo: self.bottomAnchor
        )
        textLabelLeadingConstraint = textLabelView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        )
        textLabelTrailingConstraint = textLabelView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        )
        
        arrowTopConstraint = arrowView.topAnchor.constraint(
            equalTo: self.topAnchor
        )
        arrowLeadingConstraint = arrowView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        )
        arrowTrailingConstraint = arrowView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        )
        arrowBottomConstraint = arrowView.bottomAnchor.constraint(
            equalTo: textLabelView.topAnchor,
            constant:  borderWidth > 0 ? borderWidth : 0
        )
        arrowHeightConstraint = arrowView.heightAnchor.constraint(
            equalToConstant: arrowSize + borderWidth
        )
        
        setActiveConstraint()
    }
    
    private func setConstraintWhenBottom() {
        setDeactiveConstraint()

        textLabelTopConstraint = textLabelView.topAnchor.constraint(
            equalTo: self.topAnchor
        )
        textLabelLeadingConstraint = textLabelView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        )
        textLabelTrailingConstraint = textLabelView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        )
        
        arrowTopConstraint = arrowView.topAnchor.constraint(
            equalTo: textLabelView.bottomAnchor,
            constant: borderWidth > 0 ? -borderWidth : 0
        )
        arrowLeadingConstraint = arrowView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        )
        arrowTrailingConstraint = arrowView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        )
        arrowBottomConstraint = arrowView.bottomAnchor.constraint(
            equalTo: self.bottomAnchor
        )
        arrowHeightConstraint = arrowView.heightAnchor.constraint(
            equalToConstant: arrowSize + borderWidth
        )
        
        setActiveConstraint()
    }
    
    private func setConstraintWhenLeft() {
        setDeactiveConstraint()
        
        textLabelTopConstraint = textLabelView.topAnchor.constraint(
            equalTo: self.topAnchor
        )
        textLabelBottomConstraint = textLabelView.bottomAnchor.constraint(
            equalTo: self.bottomAnchor
        )
        textLabelTrailingConstraint = textLabelView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        )
        
        arrowTopConstraint = arrowView.topAnchor.constraint(
            equalTo: self.topAnchor
        )
        arrowLeadingConstraint = arrowView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        )
        arrowTrailingConstraint = arrowView.trailingAnchor.constraint(
            equalTo: textLabelView.leadingAnchor,
            constant: borderWidth > 0 ? borderWidth : 0
        )
        arrowBottomConstraint = arrowView.bottomAnchor.constraint(
            equalTo: self.bottomAnchor
        )
        arrowWidthConstraint = arrowView.widthAnchor.constraint(
            equalToConstant: arrowSize + borderWidth
        )
        
        setActiveConstraint()
    }
    
    private func setConstraintWhenRight() {
        setDeactiveConstraint()

        textLabelTopConstraint = textLabelView.topAnchor.constraint(
            equalTo: self.topAnchor
        )
        textLabelBottomConstraint = textLabelView.bottomAnchor.constraint(
            equalTo: self.bottomAnchor
        )
        textLabelLeadingConstraint = textLabelView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        )
        
        arrowTopConstraint = arrowView.topAnchor.constraint(
            equalTo: self.topAnchor
        )
        arrowLeadingConstraint = arrowView.leadingAnchor.constraint(
            equalTo: textLabelView.trailingAnchor,
            constant: borderWidth > 0 ? -borderWidth : 0
        )
        arrowTrailingConstraint = arrowView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        )
        arrowBottomConstraint = arrowView.bottomAnchor.constraint(
            equalTo: self.bottomAnchor
        )
        arrowWidthConstraint = arrowView.widthAnchor.constraint(
            equalToConstant: arrowSize + borderWidth
        )
        
        setActiveConstraint()
    }
    
    private func setDeactiveConstraint() {
        let constraints = [
            textLabelTopConstraint,
            textLabelBottomConstraint,
            textLabelLeadingConstraint,
            textLabelTrailingConstraint,
            arrowWidthConstraint,
            arrowHeightConstraint,
            arrowTopConstraint,
            arrowBottomConstraint,
            arrowLeadingConstraint,
            arrowTrailingConstraint
        ].compactMap { $0 }
        
        NSLayoutConstraint.deactivate(constraints)
        
        textLabelTopConstraint = nil
        textLabelBottomConstraint = nil
        textLabelLeadingConstraint = nil
        textLabelTrailingConstraint = nil
        arrowWidthConstraint = nil
        arrowHeightConstraint = nil
        arrowTopConstraint = nil
        arrowBottomConstraint = nil
        arrowLeadingConstraint = nil
        arrowTrailingConstraint = nil
    }
    
    private func setActiveConstraint() {
        let constraints = [
            textLabelTopConstraint,
            textLabelBottomConstraint,
            textLabelLeadingConstraint,
            textLabelTrailingConstraint,
            arrowWidthConstraint,
            arrowHeightConstraint,
            arrowTopConstraint,
            arrowBottomConstraint,
            arrowLeadingConstraint,
            arrowTrailingConstraint
        ].compactMap { $0 }

        NSLayoutConstraint.activate(constraints)
        
        layoutIfNeeded()
        
        arrowView.redrawArrowView()
    }
    
    private func updateViewLayoutOrder() {
        self.sendSubviewToBack(textLabelView)
    }
}
