//
//  ArrowView.swift
//  SpeechBubble
//
//  Created by 전성훈 on 4/27/24.
//

import UIKit

internal final class ArrowView: UIView {
    typealias ArrowPoints = (tip: CGPoint, left: CGPoint, right: CGPoint)
    
    var arrowSize: CGFloat {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var arrowPosition: SpeechBubbleArrowPosition {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var positionRatio: CGFloat {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var style: SpeechBubbleStyleOptions {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var _filledColor: UIColor = .clear
    var filledColor: UIColor {
        get { return _filledColor }
        set {
            if !(newValue == filledColor) {
                _filledColor = newValue
                setNeedsDisplay()
            }
        }
    }
    
    private var _borderColor: UIColor = .clear
    var borderColor: UIColor {
        get { return _borderColor }
        set {
            if !(newValue == borderColor) {
                _borderColor = newValue
                setNeedsDisplay()
            }
        }
    }
    
    private var _borderWidth: CGFloat = 0
    var borderWidth: CGFloat {
        get { return _borderWidth }
        set {
            if !(newValue == borderWidth) {
                _borderWidth = newValue
                setNeedsDisplay()
            }
        }
    }
    
    init(
        arrowSize: CGFloat,
        arrowPosition: SpeechBubbleArrowPosition,
        positionRatio: CGFloat,
        style: SpeechBubbleStyleOptions,
        filledColor: UIColor,
        borderColor: UIColor,
        borderWidth: CGFloat
    ) {
        self.arrowSize = arrowSize
        self.arrowPosition = arrowPosition
        self.positionRatio = positionRatio
        self.style = style
        
        super.init(frame: .zero)
        
        self.filledColor = filledColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func redrawArrowView() {
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        let position = calculateArrowPosition(rect: rect)
        let arrowPoints = calculateArrowPoints(position: position, rect: rect)
        
        drawArrow(arrowPoints: arrowPoints)
    }
    
    private func calculateArrowPosition(rect: CGRect) -> CGFloat {
        switch arrowPosition {
        case .top, .bottom:
            return rect.width * positionRatio
        case .left, .right:
            return rect.height * positionRatio
        }
    }
    
    private func calculateArrowPoints(position: CGFloat, rect: CGRect) -> ArrowPoints {
        let pointTip: CGPoint
        let pointLeft: CGPoint
        let pointRight: CGPoint
        
        switch arrowPosition {
        case .top:
            pointTip = CGPoint(x: position, y: rect.height - arrowSize)
            pointLeft = CGPoint(x: position - arrowSize, y: rect.height)
            pointRight = CGPoint(x: position + arrowSize, y: rect.height)
        case .bottom:
            pointTip = CGPoint(x: position, y: arrowSize)
            pointLeft = CGPoint(x: position - arrowSize, y: 0)
            pointRight = CGPoint(x: position + arrowSize, y: 0)
        case .left:
            pointTip = CGPoint(x: borderWidth, y: position)
            pointLeft = CGPoint(x: arrowSize + borderWidth  , y: position - arrowSize)
            pointRight = CGPoint(x: arrowSize + borderWidth, y: position + arrowSize)
        case .right:
            pointTip = CGPoint(x: rect.width - borderWidth, y: position)
            pointLeft = CGPoint(x: rect.width - (arrowSize + borderWidth), y: position - arrowSize)
            pointRight = CGPoint(x: rect.width - (arrowSize + borderWidth), y: position + arrowSize)
        }
        
        return (pointTip, pointLeft, pointRight)
    }
    
    private func drawArrow(arrowPoints: ArrowPoints) {
        let path = UIBezierPath()
                
        path.move(to: arrowPoints.left)
        path.addLine(to: arrowPoints.tip)
        path.addLine(to: arrowPoints.right)
        
        if style.contains(.fill) {
            filledColor.setFill()
            path.fill()
        } else {
            UIColor.systemBackground.setFill()
            path.fill()
        }
        
        if style.contains(.line) || style.contains(.dottedLine) {
            borderColor.setStroke()
            
            if style.contains(.dottedLine) {
                let dashPattern: [CGFloat] = dottedLinePattern(with: borderWidth)
                path.setLineDash(dashPattern, count: dashPattern.count, phase: 0)
            }
        } else {
            filledColor.setStroke()
        }
        
        path.lineWidth = borderWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        
        path.stroke()
    }
}
