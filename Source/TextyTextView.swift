// Copyright (c) 2018 Vectorform, LLC
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
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
    public var style: TextStyle {
        willSet { self.style.delegate = nil }
        didSet {
            self.style = TextStyle(with: self.style)
            self.style.delegate = self
            self.redrawText()
        }
    }
    
    // The purpose of this variable is to keep a reference to the original text, including all contained tags. Once a
    // style is applied to a string, all tags are stripped and lost forever.
    private var taggedText: String?
    
    open override var font: UIFont? {
        get { return self.style.font }
        set { self.style.font = newValue }
    }
    
    open override var text: String? {
        get { return self.attributedText?.string }
        set {
            self.taggedText = newValue
            self.redrawText()
        }
    }
    
    open override var textAlignment: NSTextAlignment {
        get { return self.style.paragraphStyle!.alignment }
        set {
            let paragraphStyle: NSMutableParagraphStyle = style.paragraphStyle!.mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.alignment = newValue
            style.paragraphStyle = paragraphStyle
        }
    }
    
    open override var textColor: UIColor! {
        get { return self.style.foregroundColor }
        set { self.style.foregroundColor = newValue }
    }
    
    public convenience init() {
        self.init(style: TextStyle())
    }
    
    public required init(style: TextStyle, frame: CGRect = .zero) {
        self.style = style
        
        super.init(frame: frame, textContainer: nil)
        self.isEditable = false
        
        // Ensure didSet is called in self.style
        ({ self.style = style })()
        self.loadDefaults()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Interface Builder is not supported")
    }
    
    internal func didUpdate(style: TextStyle) {
        self.redrawText()
    }
    
    private func loadDefaults() {
        if self.style.font == nil {
            self.style.font = super.font
        }
        
        if self.style.foregroundColor == nil {
            self.style.foregroundColor = super.textColor
        }
        
        if self.style.paragraphStyle == nil {
            let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            paragraphStyle.lineBreakMode = .byWordWrapping
            self.style.paragraphStyle = paragraphStyle
        }
    }
    
    private func redrawText() {
        self.attributedText = style.attributedString(with: self.taggedText)
    }
}
