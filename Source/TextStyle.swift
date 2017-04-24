// Copyright (c) 2017 Vectorform, LLC
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its contributors may
// be used to endorse or promote products derived from this software without
// specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
// NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.


import Foundation
import UIKit


//TODO: Fix position of forward slash in tags to </bold> - not <bold/>
//TODO: Figure out a way to support tagged strings with < or > in the string itself (spaces present? or lack of a balanced end tag)
//TODO: Allow uneven tags (i.e. <bold>My name <underline> is: <bold/>Igor<underline/>)
//TODO: Create appearance proxy


public protocol TextStyleDelegate: class {
    
    func didUpdate(style: TextStyle) -> Void
    
}


public struct TextStyle {
    
    public weak var delegate: TextStyleDelegate?
    
    fileprivate var attributes: [String : Any] = [:]
    
    fileprivate var taggedAttributes: [String : TextStyle] = [:]
    
    
    public init(attributes: [TextAttribute : Any]? = nil) {
        guard let attributes = attributes else {
            return
        }
        self.attributes = TextAttribute.convert(attributes: attributes)
    }
    
    
    private func findStyle(forTag: String) -> TextStyle? {
        return self.taggedAttributes.filter { $0.key == forTag }.first?.value
    }
    
    fileprivate mutating func set(value: Any?, for key: TextAttribute) {
        if let v = value {
            self.attributes[key.NSAttribute] = v
        } else {
            self.attributes.removeValue(forKey: key.NSAttribute)
        }
        self.delegate?.didUpdate(style: self)
    }
    
    public func attributedString(with string: String) -> NSAttributedString {
        var mutableString: String = string
        var attributedString: NSMutableAttributedString
        
        if(self.taggedAttributes.count > 0) {
            let tags: [(String, NSRange)] = mutableString.findAndRemoveTags()        //This has to happen here because mutableString will be mutated in the stripTags() function
            attributedString = NSMutableAttributedString(string: mutableString, attributes: self.attributes)
            
            for (name, range) in tags {
                let style: TextStyle! = self.findStyle(forTag: name)
                assert(style != nil, "unregistered tag \"<\(name)>\" found in string")
                attributedString.addAttributes(style.attributes, range: range)
            }
        } else {
            attributedString = NSMutableAttributedString(string: mutableString, attributes: self.attributes)
        }
        
        
        return attributedString
    }
    
    public mutating func setAttributes(_ attributes: [TextAttribute : Any], forTag: String) {
        self.taggedAttributes[forTag] = TextStyle(attributes: attributes)
        self.delegate?.didUpdate(style: self)
    }
    
}


public extension TextStyle {
    
    public var attachment: NSTextAttachment? {
        get { return self.attributes[TextAttribute.attachment.NSAttribute] as? NSTextAttachment }
        set { self.set(value: newValue, for: TextAttribute.attachment) }
    }
    
    public var backgroundColor: UIColor? {
        get { return self.attributes[TextAttribute.backgroundColor.NSAttribute] as? UIColor }
        set { self.set(value: newValue, for: TextAttribute.backgroundColor) }
    }
    
    public var baselineOffset: NSNumber? {
        get { return self.attributes[TextAttribute.baselineOffset.NSAttribute] as? NSNumber }
        set { self.set(value: newValue, for: TextAttribute.baselineOffset) }
    }
    
    public var expansion: NSNumber? {
        get { return self.attributes[TextAttribute.expansion.NSAttribute] as? NSNumber }
        set { self.set(value: newValue, for: TextAttribute.expansion) }
    }
    
    public var font: UIFont? {
        get { return self.attributes[TextAttribute.font.NSAttribute] as? UIFont }
        set { self.set(value: newValue, for: TextAttribute.font) }
    }
    
    public var foregroundColor: UIColor? {
        get { return self.attributes[TextAttribute.foregroundColor.NSAttribute] as? UIColor }
        set { self.set(value: newValue, for: TextAttribute.foregroundColor) }
    }
    
    public var kern: NSNumber? {
        get { return self.attributes[TextAttribute.kern.NSAttribute] as? NSNumber }
        set { self.set(value: newValue, for: TextAttribute.kern) }
    }
    
    public var ligature: NSNumber? {
        get { return self.attributes[TextAttribute.ligature.NSAttribute] as? NSNumber }
        set { self.set(value: newValue, for: TextAttribute.ligature) }
    }
    
    public var linkString: NSString? {
        get { return self.attributes[TextAttribute.link.NSAttribute] as? NSString }
        set { self.set(value: newValue, for: TextAttribute.link) }
    }
    
    public var linkURL: NSURL? {
        get { return self.attributes[TextAttribute.link.NSAttribute] as? NSURL }
        set { self.set(value: newValue, for: TextAttribute.link) }
    }
    
    public var obliqueness: NSNumber? {
        get { return self.attributes[TextAttribute.obliqueness.NSAttribute] as? NSNumber }
        set { self.set(value: newValue, for: TextAttribute.obliqueness) }
    }
    
    public var paragraphStyle: NSParagraphStyle? {
        get { return self.attributes[TextAttribute.paragraphStyle.NSAttribute] as? NSParagraphStyle }
        set { self.set(value: newValue, for: TextAttribute.paragraphStyle) }
    }
    
    public var shadow: NSShadow? {
        get { return self.attributes[TextAttribute.shadow.NSAttribute] as? NSShadow }
        set { self.set(value: newValue, for: TextAttribute.shadow) }
    }
    
    public var strikethroughColor: UIColor? {
        get { return self.attributes[TextAttribute.strikethroughColor.NSAttribute] as? UIColor }
        set { self.set(value: newValue, for: TextAttribute.strikethroughColor) }
    }
    
    public var strikethroughStyle: NSNumber? {
        get { return self.attributes[TextAttribute.strikethroughStyle.NSAttribute] as? NSNumber }
        set { self.set(value: newValue, for: TextAttribute.strikethroughStyle) }
    }
    
    public var strokeColor: UIColor? {
        get { return self.attributes[TextAttribute.strokeColor.NSAttribute] as? UIColor }
        set { self.set(value: newValue, for: TextAttribute.strokeColor) }
    }
    
    public var strokeWidth: NSNumber? {
        get { return self.attributes[TextAttribute.strokeWidth.NSAttribute] as? NSNumber }
        set { self.set(value: newValue, for: TextAttribute.strokeWidth) }
    }
    
    public var textEffect: NSString? {
        get { return self.attributes[TextAttribute.textEffect.NSAttribute] as? NSString }
        set { self.set(value: newValue, for: TextAttribute.textEffect) }
    }
    
    public var underlineColor: UIColor? {
        get { return self.attributes[TextAttribute.underlineColor.NSAttribute] as? UIColor }
        set { self.set(value: newValue, for: TextAttribute.underlineColor) }
    }
    
    public var underlineStyle: NSNumber? {
        get { return self.attributes[TextAttribute.underlineStyle.NSAttribute] as? NSNumber }
        set { self.set(value: newValue, for: TextAttribute.underlineStyle) }
    }
    
    public var verticalGlyphForm: NSNumber? {
        get { return self.attributes[TextAttribute.verticalGlyphForm.NSAttribute] as? NSNumber }
        set { self.set(value: newValue, for: TextAttribute.verticalGlyphForm) }
    }
    
    public var writingDirection: [NSNumber]? {
        get { return self.attributes[TextAttribute.writingDirection.NSAttribute] as? [NSNumber] }
        set { self.set(value: newValue, for: TextAttribute.writingDirection) }
    }

}