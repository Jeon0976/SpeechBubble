//
//  UIView+Extension.swift
//  SpeechBubble
//
//  Created by 전성훈 on 4/29/24.
//

import UIKit

internal extension UIView {
    @objc func dottedLinePattern(with borderWidth: CGFloat) -> [CGFloat] {
        let dashLength = borderWidth * 3
        let dashSpacing = borderWidth * 2
        
        return [dashLength, dashSpacing]
    }
}
