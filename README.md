# Texty
Created and maintained by Vectorform.

Texty is a POD whose goal is to make managing styles and annotated strings clean and easy

# Getting started

### Create TextStyles
```swift
//this is the default way to create TextStyles and generally should be extended or subclassed as needed for a particular project
//Note: foregroundColor is basically textColor
struct Styles {
  static let Header1: TextStyle = TextStyle(attributes: [.foregroundColor : UIColor.black, .font : UIFont.boldSystemFont(ofSize: 24.0)])
}


```
There is a hefty number of attributes available to apply to any TextStyle (see TextAttribute.swift file)
### Create/Modify Texty Labels with Style!

```swift
let titleLabel: TextyLabel = TextyLabel(style: Styles.Header1)


//for properties native to a Label, variables can be changed directly or thru the style
titleLabel.textColor = UIColor.blue
titleLabel.textAlignment = .right

//for properties more associated with a TextStyle, must be changed thru the style
titleLabel.style.kern = newValue
titleLabel.style.underlineStyle = newUnderlineStyle
```

### Applying TextStyles to TextyLabel Tags
Tags can be used to apply TextAttributes to PART of the text in a TextyLabel.  The tag is a string key that is inserted into the text similar to an HTML tag
```swift

self.titleLabel.style.add(attributes: [TextAttribute.underlineStyle : NSNumber(value: NSUnderlineStyle.styleSingle.rawValue)], forTag: "underline")
self.titleLabel.text = "This is a <underline>TextyLabel<underline/>"

```

## Requirements:

- CocoaPods 1.0.0+

# Installation
### Cocoapods
Yarp can be added to your project using [CocoaPods](http://blog.cocoapods.org/Pod-Authors-Guide-to-CocoaPods-Frameworks/) by adding the following line to your `Podfile`:

```ruby
pod 'Texty', '~> 0.1.0'
```
## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Authors

Igor Efremov, iefremov@vectorform.com

## License

Yarp is available under the BSD license. See the [LICENSE](LICENSE) file for more info.
