// Copyright (c) 2018 Vectorform, LLC
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

public enum TextAttribute: String {
    case attachment = "attachment"
    case backgroundColor = "backgroundColor"
    case baselineOffset = "baselineOffset"
    case expansion = "expansion"
    case font = "font"
    case foregroundColor = "foregroundColor"
    case kern = "kern"
    case ligature = "ligature"
    case link = "link"
    case obliqueness = "obliqueness"
    case paragraphStyle = "paragraphStyle"
    case shadow = "shadow"
    case strikethroughColor = "strikethroughColor"
    case strikethroughStyle = "strikethroughStyle"
    case strokeColor = "strokeColor"
    case strokeWidth = "strokeWidth"
    case textEffect = "textEffect"
    case underlineColor = "underlineColor"
    case underlineStyle = "underlineStyle"
    case verticalGlyphForm = "verticalGlyphForm"
    case writingDirection = "writingDirection"
    
    /** macOS **/
    // case cursor
    // case markedClauseSegment
    // case spellingState
    // case superscript
    // case textAlternatives
    // case toolTip
    
    internal var NSAttribute: NSAttributedString.Key {
        switch(self) {
        case .attachment:           return NSAttributedString.Key.attachment
        case .backgroundColor:      return NSAttributedString.Key.backgroundColor
        case .baselineOffset:       return NSAttributedString.Key.baselineOffset
        case .expansion:            return NSAttributedString.Key.expansion
        case .font:                 return NSAttributedString.Key.font
        case .foregroundColor:      return NSAttributedString.Key.foregroundColor
        case .kern:                 return NSAttributedString.Key.kern
        case .ligature:             return NSAttributedString.Key.ligature
        case .link:                 return NSAttributedString.Key.link
        case .obliqueness:          return NSAttributedString.Key.obliqueness
        case .paragraphStyle:       return NSAttributedString.Key.paragraphStyle
        case .shadow:               return NSAttributedString.Key.shadow
        case .strikethroughColor:   return NSAttributedString.Key.strikethroughColor
        case .strikethroughStyle:   return NSAttributedString.Key.strikethroughStyle
        case .strokeColor:          return NSAttributedString.Key.strokeColor
        case .strokeWidth:          return NSAttributedString.Key.strokeWidth
        case .textEffect:           return NSAttributedString.Key.textEffect
        case .underlineColor:       return NSAttributedString.Key.underlineColor
        case .underlineStyle:       return NSAttributedString.Key.underlineStyle
        case .verticalGlyphForm:    return NSAttributedString.Key.verticalGlyphForm
        case .writingDirection:     return NSAttributedString.Key.writingDirection
        }
    }
    
    internal var properTypeString: String {
        switch(self) {
        case .attachment:           return "NSTextAttachment"
        case .font:                 return "UIFont"
        case .link:                 return "NSURL or NSString"
        case .paragraphStyle:       return "NSParagraphStyle"
        case .shadow:               return "NSShadow"
        case .textEffect:           return "NSString"
        case .writingDirection:     return "Array<NSNumber>"
            
        case .backgroundColor, .foregroundColor, .strikethroughColor, .strokeColor, .underlineColor:                                                return "UIColor"
        case .baselineOffset, .expansion, .kern, .ligature, .obliqueness, .strikethroughStyle, .strokeWidth, .underlineStyle, .verticalGlyphForm:   return "NSNumber"
        }
    }
    
    internal static func convertToNative(_ attributes: [TextAttribute : Any]) -> [NSAttributedString.Key: Any] {
        var convertedAttributes: [NSAttributedString.Key : Any] = [:]
        
        attributes.forEach { (key, value) in
            assert(key.isProperType(object: value), "Texty: value for attribute \"\(key.rawValue)\" is \"\(String(describing: type(of: value)))\" - should be \"\(key.properTypeString)\"")
            convertedAttributes[key.NSAttribute] = value
        }
        
        return convertedAttributes
    }
    
    internal func isProperType(object: Any) -> Bool {
        switch(self) {
        case .attachment:           return (object is NSTextAttachment)
        case .font:                 return (object is UIFont)
        case .paragraphStyle:       return (object is NSParagraphStyle)
        case .shadow:               return (object is NSShadow)
        case .textEffect:           return (object is NSString)
        case .writingDirection:     return (object is [NSNumber])
        case .link:                 return ((object is NSURL) || (object is NSString))
            
        case .backgroundColor, .foregroundColor, .strikethroughColor, .strokeColor, .underlineColor:                                                return (object is UIColor)
        case .baselineOffset, .expansion, .kern, .ligature, .obliqueness, .strikethroughStyle, .strokeWidth, .underlineStyle, .verticalGlyphForm:   return (object is NSNumber)
        }
    }
}

