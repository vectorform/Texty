[![Build Status](https://travis-ci.org/vectorform/Texty.svg)](https://travis-ci.org/vectorform/Texty)
[![Platform](https://img.shields.io/cocoapods/p/Texty.svg?style=flat)](http://cocoadocs.org/docsets/Texty)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Texty.svg)](https://img.shields.io/cocoapods/v/Texty.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Texty
Texty's goal is to make styling text clean and easy. This is accomplished using things like style containers, styled label initializers, and string styling via XML-like tags.

Created and maintained by Vectorform, LLC.


## Requirements:
- iOS 8.0+
- Xcode 10.0+
- Swift 5.0+


## Installation
### CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:
```bash
$ gem install cocoapods
```

> CocoaPods 1.0.0+ is required to build Texty.

To integrate Texty into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Texty', '~> 0.2.6'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:
```bash
$ brew update
$ brew install carthage
```

To integrate Texty into your Xcode project using Carthage, specify it in your `Cartfile`:
```ogdl
github "Vectorform/Texty" ~> 0.2.6
```

Run `carthage update` to build the framework and drag the built `Texty.framework` into your Xcode project.


### Manually
If you prefer not to use any of the listed dependency managers, you can integrate Texty into your project manually.


---


## Usage
### Creating styles
The TextStyle class was designed to be created once and reused across your entire application. If you need to manipulate a TextStyle without affecting the original, you'll need to use the copy initializer `UITextStyle(with: TextStyle)`
```swift
/// Create static references to reusable styles
struct Style {
    static let Header1: TextStyle = TextStyle(attributes: [.foregroundColor : UIColor.black, .font : UIFont.boldSystemFont(ofSize: 24.0)])

    static let Header2: TextStyle = TextStyle(attributes: [.foregroundColor : UIColor.black, .font : UIFont.boldSystemFont(ofSize: 20.0)])

    static let Normal: TextStyle = TextStyle(attributes: [.foregroundColor : UIColor.black, .font : UIFont.systemFont(ofSize: 17.0)])

    static let Underline: TextStyle = TextStyle(attributes: [TextAttribute.underlineStyle : NSUnderlineStyle.styleSingle])
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
| TextAttribute      | Expected Type     | Native Equivalent                        |
|--------------------|-------------------|------------------------------------------|
| attachment         | NSTextAttachment  | NSAttributedStringKey.attachment         |
| backgroundColor    | UIColor           | NSAttributedStringKey.backgroundColor    |
| baselineOffset     | NSNumber          | NSAttributedStringKey.baselineOffset     |
| expansion          | NSNumber          | NSAttributedStringKey.expansion          |
| font               | UIFont            | NSAttributedStringKey.font               |
| foregroundColor    | UIColor           | NSAttributedStringKey.foregroundColor    |
| kern               | NSNumber          | NSAttributedStringKey.kern               |
| ligature           | NSNumber          | NSAttributedStringKey.ligature           |
| link               | NSURL or NSString | NSAttributedStringKey.link               |
| obliqueness        | NSNumber          | NSAttributedStringKey.obliqueness        |
| paragraphStyle     | NSParagraphStyle  | NSAttributedStringKey.paragraphStyle     |
| shadow             | NSShadow          | NSAttributedStringKey.shadow             |
| strikethroughColor | UIColor           | NSAttributedStringKey.strikethroughColor |
| strikethroughStyle | NSNumber          | NSAttributedStringKey.strikethroughStyle |
| strokeColor        | UIColor           | NSAttributedStringKey.strokeColor        |
| strokeWidth        | NSNumber          | NSAttributedStringKey.strokeWidth        |
| textEffect         | NSString          | NSAttributedStringKey.textEffect         |
| underlineColor     | UIColor           | NSAttributedStringKey.underlineColor     |
| underlineStyle     | NSNumber          | NSAttributedStringKey.underlineStyle     |
| verticalGlyphForm  | NSNumber          | NSAttributedStringKey.verticalGlyphForm  |
| writingDirection   | Array\<NSNumber\> | NSAttributedStringKey.writingDirection   |

More information about each attribute can be found in Apple's [documentation](https://developer.apple.com/documentation/foundation/nsattributedstringkey).


### TextyLabel
TextyLabel is a subclass of UILabel created specifically to work with TextStyle objects. The core power of TextyLabel comes from its initializer. TextyLabel will create a copy of the TextStyle object.
```swift
let titleLabel: TextyLabel = TextyLabel(style: Style.Header1)
```
You can manipulate or replace the style later using the `style` property.

Be careful when subclassing TextyLabel as some properties are overriden to be referenced from the associated style object rather than their native locations.

Subclassing TextyLabel and overriding one of these properties without calling the super class ***will*** result in undefined behavior.

| Property      | Overriden Target                   |
|---------------|------------------------------------|
| font          | style.font                         |
| lineBreakMode | style.paragraphStyle.lineBreakMode |
| text          | attributedText                     |
| textAlignment | style.paragraphStyle.alignment     |
| textColor     | style.foregroundColor              |

### TextyButton
TextyButton is a subclass of UIButton created specifically to work with TextStyle objects. TextyButton can be initialized in the same way as TextyLabel. Internally this will be used as the style for all button states. TextyButton will create a copy of the TextStyle object.
```swift
let button: TextyButton = TextyButton(style: Style.Header1)
```
You can manipulate or replace the styles later using the following functions:
```swift
style(for state: UIControlState)
setStyle(_ style: TextStyle, for state: UIControlState)
```

Be careful when subclassing TextyButton as some properties are overriden to be referenced from the associated style object rather than their native locations.

Subclassing TextyButton and overriding one of these properties without calling the super class ***will*** result in undefined behavior.

| Function      | Overriden Target                   |
|---------------|------------------------------------|
| setTitle(_ title: String?, for state: UIControlState) | setAttributedTitle(_ title: NSAttributedString?, for state: UIControlState) |
| title(for state: UIControlState)          | attributedTitle(for: state)                     |
| setTitleColor(_ color: UIColor?, for state: UIControlState) | style(for: state).foregroundColor
| titleColor(for state: UIControlState)     | style(for: state).foregroundColor              |
| setTitleShadowColor(_ color: UIColor?, for state: UIControlState) | style(for: state).shadow |
| titleShadowColor(for state: UIControlState)| style(for: state).shadow |

### TextyTextView
TextyTextView is a subclass of UITextView created specifically to work with TextStyle objects. The core power of TextyTextView comes from its initializer. TextyTextView will create a copy of the TextStyle object.
```swift
let titleLabel: TextyLabel = TextyLabel(style: Style.Header1)
```
**TextyTextView does not currently support editing text** so you should have `isEditable` set to `false`.

You can manipulate or replace the style later using the `style` property.

Be careful when subclassing TextyTextView as some properties are overriden to be referenced from the associated style object rather than their native locations.

Subclassing TextyTextView and overriding one of these properties without calling the super class ***will*** result in undefined behavior.

| Property      | Overriden Target                   |
|---------------|------------------------------------|
| font          | style.font                         |
| lineBreakMode | style.paragraphStyle.lineBreakMode |
| text          | attributedText                     |
| textAlignment | style.paragraphStyle.alignment     |
| textColor     | style.foregroundColor              |

### Styling text via tags
Texty provides the ability to style parts of a string using XML-like tags within the string.
```swift
let titleLabel: TextyLabel = TextyLabel(style: Style.Header1)
self.titleLabel.style.setStyle(Style.Underline, forTag: "underline")
self.titleLabel.text = "This is a <underline>TextyLabel</underline>"
```

You can also forego creating a TextStyle and use an attribute dictionary instead.
```swift
let titleLabel: TextyLabel = TextyLabel(style: Style.Header1)
self.titleLabel.style.setAttributes([TextAttribute.underlineStyle : NSUnderlineStyle.styleSingle.rawValue], forTag: "underline")
self.titleLabel.text = "This is a <underline>TextyLabel</underline>"
```

Unlike XML, tags do not have to be balanced. For example, the following string is valid (given that the bold and italic tags are defined):

```This is <italic>an example <bold>string used</italic> for demonstration</bold> purposes.```

**It is important that your closing tags have the forward slash at the beginning and not the end.**

| Good      | Bad       |
|-----------|-----------|
| \</bold\> | \<bold/\> |

Forward slashes at the end of a tag will cause the tag to be detected as a *short tag*, which will have a use in the future, but currently offers nothing.

**There is currently no way to escape tags within a string - all tags will be stripped during the styling process.**


---


## Credits
[Igor Efremov](https://github.com/igorefremov), [igor@efremov.io](mailto:igor@efremov.io)

[Jeff Meador](https://github.com/jeffMeador), [jmeador@vectorform.com](mailto:jmeador@vectorform.com)

## License
Texty is available under the [BSD-3-Clause](https://opensource.org/licenses/BSD-3-Clause) License. See the [LICENSE](LICENSE) file for more info.
