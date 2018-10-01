// Copyright (c) 2017 Vectorform, LLC
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
///Users/cbechtel/Desktop/Yarp Repo/Yarp/README.md
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

open class TextyTextView: UITextView, TextStyleDelegate {
    public var style: TextStyle? {
        willSet { self.style?.delegate = nil }
        didSet {
            if let newStyle: TextStyle = self.style {
                self.style = TextStyle(with: newStyle)
                newStyle.delegate = self
            }
            
            self.redrawText()
        }
    }
    
    // The purpose of this variable is to keep a reference to the original text, including all contained tags. Once a
    // style is applied to a string, all tags are stripped and lost forever.
    private var taggedText: String?
    
    open override var font: UIFont? {
        get { return self.style?.font ?? super.font }
        set {
            if let style: TextStyle = self.style {
                style.font = newValue
            } else {
                super.font = newValue
            }
        }
    }
    
    open override var text: String? {
        get { return (self.style == nil ? super.text : self.attributedText?.string) }
        set {
            self.taggedText = newValue
            self.redrawText()
        }
    }
    
    open override var textAlignment: NSTextAlignment {
        get { return self.style?.paragraphStyle!.alignment ?? super.textAlignment }
        set {
            if let style: TextStyle = self.style {
                let paragraphStyle: NSMutableParagraphStyle = style.paragraphStyle!.mutableCopy() as! NSMutableParagraphStyle
                paragraphStyle.alignment = newValue
                style.paragraphStyle = paragraphStyle
            } else {
                super.textAlignment = newValue
            }
        }
    }
    
    open override var textColor: UIColor! {
        get { return self.style?.foregroundColor ?? super.textColor }
        set {
            if let style: TextStyle = self.style {
                style.foregroundColor = newValue
            } else {
                super.textColor = newValue
            }
        }
    }
    
    public convenience init() {
        self.init(style: TextStyle())
    }
    
    public required init(style: TextStyle?, frame: CGRect = .zero) {
        super.init(frame: frame, textContainer: nil)
        self.isEditable = false
        
        // Ensure didSet is called in self.style
        ({ self.style = style })()
        
        // Set defaults values where needed
        if let style: TextStyle = self.style {
            if style.font == nil {
                style.font = super.font
            }
            
            if style.foregroundColor == nil {
                style.foregroundColor = super.textColor
            }
            
            if style.paragraphStyle == nil {
                let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .natural
                paragraphStyle.lineBreakMode = .byWordWrapping
                style.paragraphStyle = paragraphStyle
            }
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isEditable = false
    }
    
    internal func didUpdate(style: TextStyle) {
        self.redrawText()
    }
    
    private func redrawText() {
        if let style: TextStyle = self.style {
            super.text = nil
            self.attributedText = style.attributedString(with: self.taggedText)
        } else {
            self.attributedText = nil
            super.text = self.taggedText
        }
    }
}
