[![Swift 3 Compatible](https://img.shields.io/badge/swift3-compatible-4BC51D.svg?style=flat)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/cocoapods/p/Texty.svg?style=flat)](http://cocoadocs.org/docsets/Texty)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Texty.svg)](https://img.shields.io/cocoapods/v/Texty.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Texty
Created and maintained by Vectorform, LLC.

Texty's goal is to make styling text clean and easy. This is accomplished using things like style containers, styled label initializers, and string styling via XML-like tags.


## Getting started
### Creating styles
The TextStyle struct was designed to be created once and reused across your entire application.
```swift
/// Create static references to reusable styles
struct Style {
    static let Header1: TextStyle = TextStyle(attributes: [.foregroundColor : UIColor.black, .font : UIFont.boldSystemFont(ofSize: 24.0)])

    static let Header2: TextStyle = TextStyle(attributes: [.foregroundColor : UIColor.black, .font : UIFont.boldSystemFont(ofSize: 20.0)])

    static let Normal: TextStyle = TextStyle(attributes: [.foregroundColor : UIColor.black, .font : UIFont.systemFont(ofSize: 17.0)])
}
```
```swift
/// Reuse your defined styles across your entire application
class ViewController: UIViewController {
    private let headerLabel: TextyLabel = TextyLabel(style: Style.Header1)
    private let textLabel: TextyLabel = TextyLabel(style: Style.Normal)
}
```


### Available attributes
| TextAttribute      | Native Equivalent                 | Expected Type     |
|--------------------|-----------------------------------|-------------------|
| attachment         | NSAttachmentAttributeName         | NSTextAttachment  |
| backgroundColor    | NSBackgroundColorAttributeName    | UIColor           |
| baselineOffset     | NSBaselineOffsetAttributeName     | NSNumber          |
| expansion          | NSExpansionAttributeName          | NSNumber          |
| font               | NSFontAttributeName               | UIFont            |
| foregroundColor    | NSForegroundColorAttributeName    | UIColor           |
| kern               | NSKernAttributeName               | NSNumber          |
| ligature           | NSLigatureAttributeName           | NSNumber          |
| link               | NSLinkAttributeName               | NSURL or NSString |
| obliqueness        | NSObliquenessAttributeName        | NSNumber          |
| paragraphStyle     | NSParagraphStyleAttributeName     | NSParagraphStyle  |
| shadow             | NSShadowAttributeName             | NSShadow          |
| strikethroughColor | NSStrikethroughColorAttributeName | UIColor           |
| strikethroughStyle | NSStrikethroughStyleAttributeName | NSNumber          |
| strokeColor        | NSStrokeColorAttributeName        | UIColor           |
| strokeWidth        | NSStrokeWidthAttributeName        | NSNumber          |
| textEffect         | NSTextEffectAttributeName         | NSString          |
| underlineColor     | NSUnderlineColorAttributeName     | UIColor           |
| underlineStyle     | NSUnderlineStyleAttributeName     | NSNumber          |
| verticalGlyphForm  | NSVerticalGlyphFormAttributeName  | NSNumber          |
| writingDirection   | NSWritingDirectionAttributeName   | Array\<NSNumber\> |

More information about each attribute can be found in Apple's [documentation](https://developer.apple.com/reference/foundation/nsattributedstring/character_attributes).


### Create TextyLabels with style!
```swift
let titleLabel: TextyLabel = TextyLabel(style: Styles.Header1)

/// Properties available in UILabel can be changed directly or through the .style
/// property.
///
/// The .font, .linebreakMode, .textAlignment, and .textColor properties of UILabel
/// are overridden and automatically fall through to the .style property.
titleLabel.textAlignment = .right
titleLabel.textColor = UIColor.blue

/// Properties not available in UILabel must be changed through the .style
/// property.
titleLabel.style.kern = someValue
titleLabel.style.underlineStyle = someStyle
```


### Associating TextStyles with tags in strings
Tags can be used to apply TextAttribute's to text in a TextyLabel. The tag is a string key that is inserted into the text, similar to an HTML tag.

```swift
self.titleLabel.style.setAttributes([TextAttribute.underlineStyle : NSNumber(value: NSUnderlineStyle.styleSingle.rawValue)], forTag: "underline")
self.titleLabel.text = "This is a <underline>TextyLabel</underline>"
```


## Requirements:
- CocoaPods 1.0.0+


## Installation
### Cocoapods
Texty can be added to your project using [CocoaPods](http://blog.cocoapods.org/Pod-Authors-Guide-to-CocoaPods-Frameworks/) by adding the following line to your `Podfile`:

```ruby
pod 'Texty', '~> 0.1.4'
```

### Carthage
Texty can be added to your project using [Carthage](https://github.com/Carthage/Carthage/) by adding the following line to your `Cartfile`:

```ogdl
github "Vectorform/Texty" ~> 0.1.4
```

## Authors
[Igor Efremov](https://github.com/igorefremov), [iefremov@vectorform.com](mailto:iefremov@vectorform.com)


## License
Texty is available under the [BSD-3-Clause](https://opensource.org/licenses/BSD-3-Clause) License. See the [LICENSE](LICENSE) file for more info.
