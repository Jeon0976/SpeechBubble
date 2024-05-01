# SpeechBubble

[![CI Status](https://img.shields.io/travis/Jeon0976/SpeechBubble.svg?style=flat)](https://travis-ci.org/Jeon0976/SpeechBubble)
[![Version](https://img.shields.io/cocoapods/v/SpeechBubble.svg?style=flat)](https://cocoapods.org/pods/SpeechBubble)
[![License](https://img.shields.io/cocoapods/l/SpeechBubble.svg?style=flat)](https://cocoapods.org/pods/SpeechBubble)
[![Platform](https://img.shields.io/cocoapods/p/SpeechBubble.svg?style=flat)](https://cocoapods.org/pods/SpeechBubble)

## SpeechBubble

SpeechBubble is an iOS View class that incorporates both an arrow and a label view.

It is designed to dynamically adapt its presentation in response to changes in parameters, ensuring a seamless user experience.

<img src="/Images/demo.gif" width = "250" height = "450"/>

## Requirements

SpeechBubble requires iOS 13.0 or later.
It depends on the following Apple frameworks:

- Foundaiton
- UIKit

Swift Versions:

- Swift 5

## Installation

SpeechBubble is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SpeechBubble'
```

To get the full benefits import `SpeechBubble` wherever you import UIKit 
``` swift
import UIKit
import SpeechBubble
```

Swift Package Manager

SpeechBubble is available through Swift Package Manager.

## Example 
``` swift 
private let speechBubbleView1 = SpeechBubbleView(text: "test", style: .fill, arrowPosition: .top)

private let speechBubbleView2 = SpeechBubbleView(text: "test", style: .line, arrowPosition: .top, arrowPositionRatio: 0.3)

private let speechBubbleView3 = SpeechBubbleView(text: "test", style: [.fill, .dottedLine], arrowPosition: .top, arrowPositionRatio: 0.3)

private lazy var speechBubbleView4: SpeechBubbleView = {
    let view = SpeechBubbleView(text: "test", style: [.fill], arrowPosition: .top)
       
    view.textColor = .black
    view.filledColor = .systemYellow
        
    return view
}()
```
### SpeechBubble parameters 
- **text**: String **(Required)**
- **font**: UIFont - default: .systemFont(ofSize: 16, weight: .medium)
- **numberOfLines**: Int - default: 0
- **textAlignment**: NSTextAlignment - default: .center
- **textColor**: UIColor  - default: .label
- **textInset**: CGFloat  - default: 16
- **filledColor**: UIColor - default: .systemGroupedBackground
- **borderColor**: UIColor - default: .separator
- **borderWidth**: CGFloat - default: 2 
- **style**: SpeechBubbleStyleOptions **(Required)**
    - Options: fill, line, dottedLine
    - Multiple options can be combined, with dottedLine taking precedence over line.
- **clipsToBounds**: Bool - default: true 
- **cornerRadious**: CGFloat - default: 15
- **arrowSize**: CGFloat - default: 10
- **arrowPosition**: SpeechBubbleArrowPosition **(Required)**
   - Options: top, bottom, left, right
   - Only one can be selected.
- **arrowPositionRatio**: CGFloat - default: 0.5

## Author

Jeon0976, jsh097610@gmail.com

## License

SpeechBubble is available under the MIT license. See the LICENSE file for more info.
