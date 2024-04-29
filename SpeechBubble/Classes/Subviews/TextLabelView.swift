//
//  TextLabelView.swift
//  SpeechBubble
//
//  Created by 전성훈 on 4/27/24.
//

import UIKit

internal final class TextLabelView: UIView {
    var text: String {
        didSet {
            textLabel.text = text
            
            updateViewConstraints()

            if style.contains(.dottedLine) {
                layoutIfNeeded()
                updateDottedBorder()
            }
        }
    }
    
    var font: UIFont {
        didSet {
            textLabel.font = font
        }
    }
    
    var numberOfLines: Int {
        didSet {
            textLabel.numberOfLines = numberOfLines
        }
    }
    
    var textAlignment: NSTextAlignment {
        didSet {
            textLabel.textAlignment = textAlignment
        }
    }
    
    var textColor: UIColor {
        didSet {
            textLabel.textColor = textColor
        }
    }
    
    var textInset: CGFloat {
        didSet {
            updateViewConstraints()
            
            if style.contains(.dottedLine) {
                layoutIfNeeded()
                updateDottedBorder()
            }
        }
    }
    
    var style: SpeechBubbleStyleOptions {
        didSet {
            updateViewConstraints()
            updateSpeechBubbleStyle()
        }
    }
    
    private var _filledColor: UIColor = .clear
    var filledColor: UIColor {
        get { return _filledColor }
        set {
            if !(newValue == filledColor) {
                _filledColor = newValue
                updateSpeechBubbleStyle()
            }
        }
    }
    
    private var _borderColor: UIColor = .clear
    var borderColor: UIColor {
        get { return _borderColor }
        set {
            if !(newValue == borderColor) {
                _borderColor = newValue
                updateSpeechBubbleStyle()
            }
        }
    }
    
    private var _borderWidth: CGFloat = 0
    var borderWidth: CGFloat {
        get { return _borderWidth }
        set {
            if !(newValue == borderWidth) {
                _borderWidth = newValue
                updateSpeechBubbleStyle()
            }
        }
    }

    private var dottedBorderLayer: CAShapeLayer?
    
    private var textLabelTopConstraint: NSLayoutConstraint?
    private var textLabelBottomConstraint: NSLayoutConstraint?
    private var textLabelLeadingConstraint: NSLayoutConstraint?
    private var textLabelTrailingConstraint: NSLayoutConstraint?
    private var afterInitSetConstraint = false
    
    private let textLabel = UILabel()

    init(
        text: String,
        font: UIFont,
        numberOfLines: Int,
        textAlignment: NSTextAlignment,
        textColor: UIColor,
        textInset: CGFloat,
        style: SpeechBubbleStyleOptions,
        filedColor: UIColor,
        borderColor: UIColor,
        borderWidth: CGFloat,
        clipsToBounds: Bool,
        cornerRadious: CGFloat
    ) {
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.textInset = textInset
        self.style = style

        super.init(frame: .zero)

        self.filledColor = filedColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = cornerRadious

        self.textLabel.text = text
        self.textLabel.font = font
        self.textLabel.numberOfLines = numberOfLines
        self.textLabel.textAlignment = textAlignment
        self.textLabel.textColor = textColor
        
        setLayout()
        setConstraints()
        setActiveConstraint()

        setSpeechBubbleStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !afterInitSetConstraint {
            afterInitSetConstraint.toggle()
            
            if style.contains(.dottedLine) {
                updateDottedBorder()
            }
        }
    }
        
    private func setLayout() {
        [
            textLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
    
    private func updateViewConstraints() {
        setDeativeConstraint()
        setConstraints()
        setActiveConstraint()
    }
        
    private func setConstraints() {
        let borderWidth = borderWidth > 0 ? borderWidth : 0
        let textInset = self.textInset + borderWidth

        textLabelTopConstraint = textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: textInset)
        textLabelBottomConstraint = textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -textInset)
        textLabelLeadingConstraint = textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textInset)
        textLabelTrailingConstraint = textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -textInset)
    }
    
    private func setDeativeConstraint() {
        let constraints = [
            textLabelTopConstraint,
            textLabelBottomConstraint,
            textLabelLeadingConstraint,
            textLabelTrailingConstraint
        ].compactMap { $0 }
        
        NSLayoutConstraint.deactivate(constraints)
        
        textLabelTopConstraint = nil
        textLabelBottomConstraint = nil
        textLabelLeadingConstraint = nil
        textLabelTrailingConstraint = nil
    }
    
    private func setActiveConstraint() {
        let constraints = [
            textLabelTopConstraint,
            textLabelBottomConstraint,
            textLabelLeadingConstraint,
            textLabelTrailingConstraint
        ].compactMap { $0 }

        NSLayoutConstraint.activate(constraints)
    }
    
    private func setSpeechBubbleStyle() {
        self.backgroundColor = style.contains(.fill) ? filledColor : .systemBackground
        
        self.layer.borderColor = style.contains(.line) ? borderColor.cgColor : filledColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    internal func updateDottedBorder() {
        self.layer.borderColor = nil
        self.layer.borderWidth = 0
        
        removeDottedBorder()
        // TODO: Error: this application, or a library it uses, has passed an invalid numeric value (NaN, or not-a-number) to CoreGraphics API and this value is being ignored
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = borderColor.cgColor
        shapeLayer.lineWidth = borderWidth * 2
        shapeLayer.fillColor = nil
        shapeLayer.lineDashPattern = self.dottedLinePattern(with: borderWidth).map { NSNumber(value: Float($0))}
        
        layer.addSublayer(shapeLayer)
        dottedBorderLayer = shapeLayer
        
        
        dottedBorderLayer?.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    private func removeDottedBorder() {
        dottedBorderLayer?.removeFromSuperlayer()
        dottedBorderLayer = nil
    }
    
    private func updateSpeechBubbleStyle() {
        setSpeechBubbleStyle()
        
        if style.contains(.dottedLine) {
            updateDottedBorder()
        } else {
            removeDottedBorder()
        }
    }
}
