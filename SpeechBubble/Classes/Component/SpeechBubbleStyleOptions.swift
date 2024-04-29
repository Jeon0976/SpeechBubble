//
//  SpeechBubbleStyleOptions.swift
//  SpeechBubble
//
//  Created by 전성훈 on 4/28/24.
//

import Foundation

public struct SpeechBubbleStyleOptions: OptionSet {
    public let rawValue: Int
    
    public static let fill = SpeechBubbleStyleOptions(rawValue: 1 << 0)
    public static let line = SpeechBubbleStyleOptions(rawValue: 1 << 1)
    public static let dottedLine = SpeechBubbleStyleOptions(rawValue: 1 << 2)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
