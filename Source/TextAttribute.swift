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
    
    
    internal var NSAttribute: String {
        switch(self) {
            
        case .attachment:           return NSAttachmentAttributeName
        case .backgroundColor:      return NSBackgroundColorAttributeName
        case .baselineOffset:       return NSBaselineOffsetAttributeName
        case .expansion:            return NSExpansionAttributeName
        case .font:                 return NSFontAttributeName
        case .foregroundColor:      return NSForegroundColorAttributeName
        case .kern:                 return NSKernAttributeName
        case .ligature:             return NSLigatureAttributeName
        case .link:                 return NSLinkAttributeName
        case .obliqueness:          return NSObliquenessAttributeName
        case .paragraphStyle:       return NSParagraphStyleAttributeName
        case .shadow:               return NSShadowAttributeName
        case .strikethroughColor:   return NSStrikethroughColorAttributeName
        case .strikethroughStyle:   return NSStrikethroughStyleAttributeName
        case .strokeColor:          return NSStrokeColorAttributeName
        case .strokeWidth:          return NSStrokeWidthAttributeName
        case .textEffect:           return NSTextEffectAttributeName
        case .underlineColor:       return NSUnderlineColorAttributeName
        case .underlineStyle:       return NSUnderlineStyleAttributeName
        case .verticalGlyphForm:    return NSVerticalGlyphFormAttributeName
        case .writingDirection:     return NSWritingDirectionAttributeName
            
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
    
    internal static func convert(attributes: [TextAttribute : Any]) -> [String : Any] {
        var convertedAttributes: [String : Any] = [:]
        
        for (k, v) in attributes {
            assert(k.isProperType(object: v), "value for attribute \"\(k.rawValue)\" is \"\(String(describing: type(of: v)))\" - should be \"\(k.properTypeString)\"")
            convertedAttributes[k.NSAttribute] = v
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

